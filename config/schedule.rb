set :output, '../../shared/log/scheduler.log'
every 1.day, at: '00:00 am' do
  rake "apartments:refresh"
end

every 1.day, at: '08:00 am' do
  rake "apartments:refresh"
end

every 1.day, at: '13:00 am' do
  rake "apartments:refresh"
end

every 1.day, at: '19:00 am' do
  rake "apartments:refresh"
end
