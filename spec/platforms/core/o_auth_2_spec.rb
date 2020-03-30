require 'rails_helper'
require 'hashie'
require 'platforms/core/o_auth_2'

module Platforms
  module Core

    # Use a shared examples block because it's easier.
    # Also the routes.draw method doesn't work in a before block
    RSpec.shared_examples "treats boolean" do |input, output|
      it "returns #{output}" do
        routes.draw {
          get "check_bool" => "platforms/core/anonymous#check_bool"
        }
        allow(controller).to receive(:bool).and_return(input)
        get :check_bool

        if input.is_a? String
          response_string = "\"#{input}\""
        elsif input.nil?
          response_string = "nil"
        else
          response_string = input.to_s
        end

        expect(subject).to eq "#{response_string} #{output}"
      end
    end

    class AnonymousController < ApplicationController; end

    # Test this in the context of a controller, with env
    RSpec.describe AnonymousController, type: :controller do
      let(:token) { "shakennotstirred" }
      subject { response.body }

      before(:each) do
        omni_token = Hashie::Mash.new({credentials: {token: token}})
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with("omniauth.auth").and_return omni_token
      end

      controller do
        include Platforms::Core::OAuth2

        attr_accessor :bool

        def index
          @output = token
          render :plain => @output
        end

        # Pass a value, and a boolean flag to convert it
        def check_bool
          @output = bool_safe(bool)
          render :plain => "#{bool.inspect} #{@output.inspect}"
        end
      end

      it "gets token from OmniAuth request.env" do
        get :index
        expect(subject).to eq "shakennotstirred"
      end

      describe "#bool_safe" do
        it_behaves_like "treats boolean", true, true
        it_behaves_like "treats boolean", "true", true
        it_behaves_like "treats boolean", false, false
        it_behaves_like "treats boolean", "false", false
        it_behaves_like "treats boolean", nil, false
        it_behaves_like "treats boolean", "other", false
      end
    end
  end
end
