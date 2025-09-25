Dado('que estou na página inicial do Google') do
  sleep 10 # Aguarda para facilitar visualização no VNC
  visit 'https://www.google.com'
  if page.has_button?('Aceitar tudo')
    click_button('Aceitar tudo')
  end
end


Quando('eu pesquiso por {string}') do |termo|
  # Tenta o campo padrão
  if page.has_selector?('input[name="q"]', wait: 5)
    fill_in('q', with: termo)
    find('input[name="q"]').send_keys(:enter)
  # Tenta campo alternativo para mobile
  elsif page.has_selector?('input[aria-label="Pesquisar"]', wait: 5)
    campo = find('input[aria-label="Pesquisar"]')
    campo.set(termo)
    campo.send_keys(:enter)
  else
    raise "Campo de busca do Google não encontrado!"
  end
end

Então('eu devo ver resultados para {string}') do |termo|
  expect(page).to have_content(termo)
end
