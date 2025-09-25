
After do |scenario|
  if scenario.failed?
    filename = "screenshot-#{Time.now.strftime('%Y%m%d-%H%M%S')}.png"
    save_path = File.join('screenshots', filename)
    begin
      FileUtils.mkdir_p('screenshots')
      page.save_screenshot(save_path)
      puts "Screenshot salvo em: #{save_path}"
    rescue => e
      puts "Erro ao salvar screenshot em #{save_path}: #{e.message}"
      # Fallback: tenta capturar screenshot via endpoint Appium
      begin
        require 'net/http'
        require 'json'
        session_id = page.driver.browser.session_id
        appium_url = ENV['SELENIUM_REMOTE_URL'] || 'http://selenium-hub:4444/wd/hub'
        uri = URI(appium_url + "/session/#{session_id}/screenshot")
        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
          data = JSON.parse(res.body)
          if data['value']
            File.open(save_path, 'wb') { |f| f.write(Base64.decode64(data['value'])) }
            puts "Screenshot Appium salvo em: #{save_path}"
          else
            puts "Appium não retornou imagem: #{data.inspect}"
          end
        else
          puts "Falha HTTP ao requisitar screenshot Appium: #{res.code} #{res.body}"
        end
      rescue => e3
        puts "Falha ao capturar screenshot via Appium: #{e3.message}"
      end
    end
  end
end
