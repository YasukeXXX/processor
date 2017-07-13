namespace :deploy do
  task :puma do
    unless File.exist?('tmp/puma.rb')
      secrets = { fetch(:stage).to_s =>
        File.open('tmp/puma.rb', 'w') do |f|
          f.write secrets.to_yaml
        end }
    end

    on roles(:app) do
      unless test "[ -f #{shared_path}/config/puma.rb ]"
        unless test "[ -d #{shared_path}/config ]"
          execute "/bin/mkdir -p #{shared_path}/config/"
        end
        upload! "tmp/puma.rb", "#{shared_path}/config/puma.rb"
      end
    end
  end
end
