module ApplicationHelper

#Retorna el nombre completo de la pagina
def full_title (page_title = '')
	base_title = 'Ruby on rails tutorial sample'
	if page_title.empty?
		base_title
	else
		page_title + ' | ' + base_title
	end
end

end
