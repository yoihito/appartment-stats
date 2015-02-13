set :output, '../../shared/log/scheduler.log'
every 8.hours do
  rake "apartments:refresh"
end
