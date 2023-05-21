# frozen_string_literal: true

module TailwindHelpers
  # Buttons classes
  def btn_search
    'bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-md cursor-pointer'
  end

  def btn_primary
    'bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-md cursor-pointer'
  end

  def btn_secondary
    'bg-transparent hover:bg-red-500 text-red-700 font-semibold hover:text-white py-2 px-4 border border-red-500 hover:border-transparent rounded-md cursor-pointer'
  end

  def btn_danger
    'bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-md cursor-pointer'
  end

  def btn_simple
    'text-red-500 hover:text-red-700 font-bold p-2'
  end

  # Forms classes
  def mobile_item_menu_classes
    'text-gray-300 hover:bg-gray-700 hover:text-white block rounded-md px-3 py-2 text-base font-medium'
  end

  def item_menu_classes
    'text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium'
  end

  def input_text
    'block w-full px-4 rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6'
  end

  def select_classes
    'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:max-w-xs sm:text-sm sm:leading-6'
  end

  def input_label
    'block text-sm font-medium leading-6 text-gray-900'
  end

  def input_label_search
    'text-sm font-medium leading-6 text-gray-500 ml-2'
  end

  def input_text_searh
    'rounded-md px-4 border-0 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6'
  end

  def input_checkbox
    'ml-1 h-4 w-4 rounded border-gray-300 text-red-600 focus:ring-red-600'
  end

  # Dropdown menu
  def dropdown_menu_item
    'block px-4 py-2 text-sm text-gray-700'
  end
end
