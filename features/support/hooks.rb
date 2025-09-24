After do |scenario|
  if scenario.failed?
    filename = "screenshot-#{Time.now.strftime('%Y%m%d-%H%M%S')}.png"
    save_path = File.join('screenshots', filename)
    FileUtils.mkdir_p('screenshots')
    page.save_screenshot(save_path)
    puts "Screenshot salvo em: #{save_path}"
  end
end
