# frozen_string_literal: true

require 'csv'
require 'date'

# This module supports parsing an export of Jira data to build a sample of
# historic throughputs that provide a more accurate forecast
# It takes the absolute path to the csv export and returns an array containing
# the number of tasks/tickets completed each week
module CSVData
  RESOLVED = 'Resolved'
  def historic_throughput(path)
    headers, *data = CSV.read(path)
    resolved_column = headers.index(RESOLVED)
    resolved_dates = data.flat_map { |row| Date.parse row[resolved_column] }
    grouped_into_weeks = resolved_dates.group_by { |date| date - date.wday }
    grouped_into_weeks.values.map(&:length)
  end
end
