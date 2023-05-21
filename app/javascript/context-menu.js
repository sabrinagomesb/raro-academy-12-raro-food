const toggleMenu = (event) => {
  const menu = document.querySelector('.context-menu');
  if (menu.classList.contains('hidden')) {
    menu.classList.remove('hidden')
  } else {
    menu.classList.add('hidden')
  }

  event.stopPropagation();
};

const userMenu = document.querySelector('#open-user-menu');
userMenu.addEventListener('click', toggleMenu);
