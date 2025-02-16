module HeaderHelper
  def header_link_to(text, path)
    classes = [
      'rounded-md px-3 py-2 text-sm font-medium',
      current_page?(path) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'
    ]

    link_to text, path, class: classes.join(' ')
  end
end
