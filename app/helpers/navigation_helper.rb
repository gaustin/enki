module NavigationHelper
  def page_links_for_navigation
    link = Struct.new(:name, :url) 
    Page.find(:all, :order => 'title').collect {|page| link.new(page.title, page_path(page)) if page.title}
  end

  def page_links_for_bottom_navigation
    link = Struct.new(:name, :url)
    [link.new("Home", posts_path), link.new("Archive", archives_path)]
  end

  def category_links_for_navigation
    link = Struct.new(:name, :url)
    top_level_tags = ["Startups", "Code"]
    @popular_tags ||= Tag.find(:all).reject {|tag| tag.taggings.empty? || !top_level_tags.include?(tag.name) }.sort_by {|tag| tag.taggings.size }.reverse
    @popular_tags.collect {|tag| link.new(tag.name, posts_path(:tag => tag))}
  end

  def class_for_tab(tab_name, index)
    classes = []
    classes << 'current' if "admin/#{tab_name.downcase}" == params[:controller]
    classes << 'first'   if index == 0
    classes.join(' ')
  end
end
