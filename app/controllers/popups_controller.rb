class PopupsController < ApplicationController
  before_action :only => [:time_issue, :time_user]
  #time_issue.html.erb ve _time_issue.html.erb olarak iki sayfa oluşturdum
  # _ taglı sayfa js isteğine yanıt verecek
  def time_issue
    @done_ratio = params[:dr]
    @estimated_hours = params[:eh]
    @spent_hours = params[:sh]
    @subject = params[:subject]

    respond_to do |format|
      format.html
      format.js  #eğer popup olarak gösterecekse js isteği yap
    end
  end

  def time_user
    @project_id= Project.find(params[:id]).id

    @records_user=TimeEntry.select("concat(users.firstname,' ',users.lastname) AS namesurname ,SUM(hours) AS totalhours")
                  .joins("INNER JOIN users ON users.id=time_entries.user_id WHERE time_entries.project_id=#{@project_id}")
                    .group("namesurname")


    @records_category=TimeEntry.select("(SELECT name FROM issue_categories WHERE issues.category_id=issue_categories.id) AS issueCatName, SUM(time_entries.hours) AS totalhours")
                  .joins("INNER JOIN issues ON issues.id=time_entries.issue_id WHERE time_entries.project_id=#{@project_id}")
                    .group("issueCatName")

    respond_to do |format|
      format.html
    end
  end

end
