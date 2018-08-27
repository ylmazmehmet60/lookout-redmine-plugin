module LookoutsHelper

  def column_header(column, options={})

    #normalde bu tarz dizileri içeren veriler model dosyası fonksiyonlarına erişerek veritabanından çekilmedir
    #ancak ben bu bir plugin olduğundan veri tabanına yeni alan eklemekten çekindiğim için dizide tutmayı tercih ettim
    arr= ["&sort=id:asc",
          "&sort=id:desc",
          "&sort=category:asc",
          "&sort=category:desc",
          "&sort=author:asc",
          "&sort=author:desc"]

    css,order = nil
    case column
    when '#'
      if @orderQuery == arr[0]
        css = 'sort asc'
        order = arr[1]
      else
        css = 'sort desc'
        order = arr[0]
      end
    when 'Category'
      if @orderQuery == arr[2]
        css = 'sort asc'
        order = arr[3]
      else
        css = 'sort desc'
        order = arr[2]
      end
    else
      if @orderQuery == arr[4]
        css = 'sort asc'
        order = arr[5]
      else
        css = 'sort desc'
        order = arr[4]
      end
    end
    link_options = {
        :class => css
      }
    content = link_to(
        column,
        { :page  => @issue_pages.page,
          :query  => order},
        link_options
      )
    content_tag('th', content)
  end


end
