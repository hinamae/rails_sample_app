module ApplicationHelper
    def full_title(page_titel='')
        base_title = "Ruby on Rails Tutorial Sample App"
        if page_titel.empty?
            base_title
        else
            page_titel +  " | " + base_title
        end
    end

end
