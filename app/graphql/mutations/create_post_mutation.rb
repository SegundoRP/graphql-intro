# frozen_string_literal: true

module Mutations
  class CreatePostMutation < BaseMutation
    field :post, Types::PostType, null: false

    argument :title, String, required: true do
      description "The title field is a string type and is required for a new Post to be created."
    end

    argument :body, String, required: true do
      description "This is the post's main content, it is called the body and it expects a string"
    end

    argument :author, Integer, required: true do
      description "The id of this post's author."
    end

    def resolve(title:, body:, author:)
      @post = Post.new(title: title, body: body, author: Author.find_by_id(author))

      if (@post.save)
        {
          post: @post,
          # Do not put another fields because first line of this class only has one field -> post
          # If you want to add more fields, you need to add them in the field declaration above
        }
      else
        raise GraphQL::ExecutionError, @post.errors.full_messages.join(", ")
      end
    end
  end
end
