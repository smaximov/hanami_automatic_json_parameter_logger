module Api::Controllers::Resource
  class Post
    include Api::Action

    def call(params)
      self.status = 204
    end
  end
end
