# rails-action-args

Rails Action Args allows you to accept the parameters to you action as
arguments to the action method.

The best way to demonstrate this is with a quick example.

First you need to include ActionArgs in your ApplicationController

    class ApplicationController < ActionController::Base
      include ActionArgs
    end

Then you simply accept arguments to your methods.

    class PostsController < ApplicationController
      respond_to :json

      def show(id)
        @post = Post.find(id)
        respond_with @post
      end
    end

    class MyApp < Rails::Application
      root :to => "posts#show"
    end

Now if this is called with {:id => 1} in the params, the id will be set to 1.

    > curl http://localhost:3000?id=1
    {"id": 1, "title":"Lorem ipsum dolor"}

If you call the action without the correct parameter, you get a 400 Bad Request

    > curl http://localhost:3000
    HTTP/1.1 400 Bad Request


You can also supply default arguments as normal.

    class PostsController < ApplicationController
      respond_to :json

      def show(id=4)
        @post = Post.find(id)
        respond_with @post
      end
    end

    > curl http://localhost:3000?id=1
    {"id": 4, "title":"Consectur sit amet"}

## Authors

This plugin is very heavily influenced by the merb-action-args plugin.
All authors of that plugin helped make this one happen.

Special thanks to Yehuda Katz for writing much of the original merb plugin
and helping convert this to Rails 3.

## Copyright

Copyright (c) 2010 Andy Delcambre. See LICENSE for details.
