class IssuesApiController < ApplicationController
  helper :custom_fields
  include QueriesHelper

  def index
    retrieve_query
      respond_to do |format|
        format.api  {
          @offset, @limit = api_offset_and_limit
          @query.column_names = %w(author)
          @issue_count = @query.issue_count
          @issues = @query.issues(:offset => @offset, :limit => @limit)
          Issue.load_visible_relations(@issues) if include_in_api_response?('relations')
        }
      end
  end
end

#Redmine apilerini direk kullanmak yerine özelleştirdim
#gereksiz alanları sildim, spent_hours ve total_spent_hours gibi alanları çektim
#bunun bize iki tane faydası vardır
#birincisi görsel grafik oluştururken popup için başka json isteği yapmayacağız
#ikincisi ise issues.json gibi isteklerden daha hızlı işlem yapacağız
