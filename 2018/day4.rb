#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'time'

LogEntry = Struct.new(:datetime, :guard, :action, keyword_init: true)

logs = []

File.open('day4.txt', 'r') do |f|
  until f.eof?
    entry = f.readline.strip

    m = entry.match(/\A\[(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2}) (?<hour>\d{2}):(?<minute>\d{2})\]( Guard #(?<guard>\d+))? (?<action>.+)\Z/)

    logs << LogEntry.new({
                           datetime: Time.new(m[:year].to_i, m[:month].to_i, m[:day].to_i, m[:hour].to_i, m[:minute].to_i),
                           guard: m[:guard].to_i,
                           action: m[:action]
                         })
  end
end

@guard_sleeping_times = Hash.new do |hash, guard_id|
  hash[guard_id] = Hash.new do |guard_hash, date|
    guard_hash[date] = Array.new(60)
  end
end

logs = logs.sort_by(&:datetime)

current_guard = nil
sleep_start_time = nil

logs.each do |log|
  case log.action
  when 'begins shift'
    current_guard = log.guard
  when 'falls asleep'
    sleep_start_time = log.datetime.min
  when 'wakes up'
    sleep_start_time.upto(log.datetime.min - 1) do |sleeping_minute|
      @guard_sleeping_times[current_guard][log.datetime.to_date][sleeping_minute] = :sleeping
    end
  end
end

# Strategy 1

minutes_sleeping_per_guard = @guard_sleeping_times.map do |guard_id, sleeptimes|
  { id: guard_id, sleeps: sleeptimes.values.flatten.compact.count }
end

guard_max_sleeper = minutes_sleeping_per_guard.max_by { |entry| entry[:sleeps] }[:id]
dates = @guard_sleeping_times[guard_max_sleeper]

max_minute = nil
max_sleeping_times = 0
0.upto(60) do |minute|
  sleeping_times = dates.values.inject(0) { |sum, array| sum + (array[minute] == :sleeping ? 1 : 0) }

  if sleeping_times > max_sleeping_times
    max_sleeping_times = sleeping_times
    max_minute = minute
  end
end

puts "Strategy 1: #{max_minute * guard_max_sleeper}"

# Strategy 2

def sleeping_count_per_guard_per_minute(guard, minute)
  @guard_sleeping_times[guard].values.count { |item| item[minute] == :sleeping }
end

guards = @guard_sleeping_times.keys

max_minute = nil
max_minute_guard = nil
max_minute_sleeping_count = 0

0.upto(60) do |minute|
  guards.each do |guard|
    count = sleeping_count_per_guard_per_minute(guard, minute)

    next unless count > max_minute_sleeping_count

    max_minute_guard = guard
    max_minute = minute
    max_minute_sleeping_count = count
  end
end

puts "Strategy 2: #{max_minute * max_minute_guard}"
