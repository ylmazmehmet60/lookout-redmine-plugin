class LookoutsController < ApplicationController
  before_filter :find_project, :authorize, :only => :index

  def index
    ###controller ve helpers arasında bir çok kez veri alışverisi yaptım
    @page_current= params[:page]    # page index al ==> lookouts?page=2&query=sort=category:asc
    path = params[:query]           # path(sorgu) index al ==> sort=category:asc,sort=category:desc
    @per_page= params[:per_page]    #(1-50/75) Sayfa başına: 25, 50, 100 gösterimi için şeçileni bul

    @orderQuery = path    #değişkeni helperde kullanmak için @ ile tanımladım
    if !path.blank? #Eğer sayfa yüklendiğinde path değişkeni boş değilse projenin adrresini ve path değişkenini request_query'e ekle
      request_query = "/shared/issues.json?project_id="+ @project.id.to_s  + path.to_s
    else
      request_query = "/shared/issues.json?project_id="+ @project.id.to_s
    end

    #PAGINATE
      #eğer paginate linklerinden [1,2,3,4] herhangi birine tıklamışsa
    if @page_current
      request_query = request_query + "&page=" + @page_current
    end

      #eğer per_page linklerinden herhangi birine tıklamışsa
    if @per_page
      request_query = request_query + "&limit=" + @per_page
    end

    @issue_count = Issue.where(project_id: @project.id.to_s).all.count

    @issue_pages = Paginator.new @issue_count, per_page_option, @page_current
    #PAGINATE END

    #parametrelerle oluşturulan adresin son hali (Vue.js'in json isteği yapması için oluşturuldu.)
    @url = "#{request.base_url}#{request_query}"

  end

  #hangi projede olduğunu bul
  def find_project
    @project = Project.find(params[:id])
  end
end
