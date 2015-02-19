set :output, '../../shared/log/scheduler.log'
every 1.day, at: ['00:00 am', '08:00 am', '1:00 pm', '7:00 pm'] do
  rake "apartments:refresh"
end
