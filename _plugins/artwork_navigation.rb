module Jekyll
  class ArtworkNavigationGenerator < Generator
    priority :low

    def generate(site)
      # Find all artwork posts
      artwork_posts = site.posts.docs.select { |post| post.data['layout'] == 'artwork' }

      # Group posts by categories
      posts_by_category = artwork_posts.group_by { |post| post.data['categories'] }

      # Process each category group
      posts_by_category.each do |category, posts|
        # Sort posts by order field (descending - higher order appears first)
        sorted_posts = posts.sort_by { |post| -(post.data['order'] || 0) }

        # Add prev/next navigation to each post
        sorted_posts.each_with_index do |post, index|
          # Previous post (higher order)
          if index > 0
            post.data['prev_artwork'] = sorted_posts[index - 1]
          end

          # Next post (lower order)
          if index < sorted_posts.length - 1
            post.data['next_artwork'] = sorted_posts[index + 1]
          end
        end
      end

      Jekyll.logger.info "ArtworkNavigation:", "Generated navigation for #{artwork_posts.length} artworks in #{posts_by_category.keys.length} categories"
    end
  end
end
