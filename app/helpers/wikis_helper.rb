module WikisHelper
    def render_markdown(string)
        renderer = Redcarpet::Render::HTML.new(render_options = {})
        markdown = Redcarpet::Markdown.new(renderer, extensions = {})
        markdown.render(string).html_safe
    end
    
    def any_collaborators(wiki)
        wiki.collaborators.present? && wiki.collaborators.length > 0
    end
end
