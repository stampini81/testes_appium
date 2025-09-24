Dado('que estou na página inicial do Google') do
  visit 'https://www.google.com'
  if page.has_button?('Aceitar tudo')
    click_button('Aceitar tudo')
  end
end

Quando('eu pesquiso por {string}') do |termo|
  fill_in('q', with: termo)
  find('input[name="q"]').send_keys(:enter)
end

Então('eu devo ver resultados para {string}') do |termo|
  expect(page).to have_content(termo)
end
