namespace :simple_private_messages do

  desc "Copy javascripts, stylesheets and images to public"
  task :install do
    Rake::Task[ "simple_private_messages:uninstall" ].execute
    %w(javascripts stylesheets).each do |dir|
      source = File.expand_path(File.join(File.dirname(__FILE__),'..', '..', 'public', dir))
      target = File.join(Rails.root, 'public', dir, 'jquery')
      FileUtils.mkdir_p target
      FileUtils.copy_entry(source, target, :verbose => true) 
    end
  end

  desc 'Remove javascripts, stylesheets and images from public'
  task :uninstall do
    %w(javascripts stylesheets).each do |dir|
      target = File.join(Rails.root, 'public', dir, 'jquery')
      FileUtils.rm_rf(target, :verbose => true)
    end
  end
  
end