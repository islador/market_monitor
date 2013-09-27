module ApplicationHelper

	#Full title attribute from Michael Hartl's Tutorial
	def full_title(page_title)
    base_title = "Market Monitor"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
