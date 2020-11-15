# frozen_string_literal: true

require 'csv'
require 'date'

RESOLVED = "Resolved"
headers, *data = CSV.read('/Users/alrw/Downloads/data.csv')
resolved_column = headers.index(RESOLVED)
resolved_dates = data.flat_map { |row| Date.parse row[resolved_column] }
sorted_dates = resolved_dates.sort
grouped_into_weeks = sorted_dates.group_by { |date| date - date.wday }
tasks_per_week = grouped_into_weeks.values.map(&:length)
