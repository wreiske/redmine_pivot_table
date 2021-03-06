class PivottablesController < ApplicationController
  unloadable

  helper :queries
  include QueriesHelper
  helper :repositories
  include RepositoriesHelper
  helper :sort
  include SortHelper
  include IssuesHelper

  def pivottables
  end

  def index
    @project = Project.find(params[:project_id])
    @language = current_language
    @language_js = "pivot." + current_language.to_s + ".js"
    @statuses = IssueStatus.sorted.collect{|s| [s.name] }

    retrieve_query
    @query.project = @project

    # Exclude description
    index = nil
    @query.available_columns.each_with_index {|column, i| index = i if column.name == :description}
    @query.available_columns.delete_at(index)

    if (params[:closed] == "1")
        @query.add_filter("status_id", "*", [''])
    else
        @query.add_filter("status_id", "o", [''])
    end

    @rows = params[:rows] ? params[:rows].split(",") : nil
    @cols = params[:cols] ? params[:cols].split(",") : nil
    @aggregatorName = params[:aggregatorName]
    @vals = params[:vals] ? params[:vals].split(",") : nil
    @rendererName = params[:rendererName]

    @issues = @query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version],
                              :offset => 0,
                              :limit => 1000)

  end

end
