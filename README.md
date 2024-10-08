Порядок запуска:
1) Создать test.key (private key) для inventory.ini и test.pub (public key) для Dockerfile, в корневой папке (у меня они в .gitignore)
2) docker compose up -d
3) ansible-playbook playbook.yml
4) Так как у контейнера запущен CMD ["/usr/sbin/sshd", "-D"], то когда ssh перезапускается, чтобы применить настройки, контейнер падает, и от этого никак не избавиться (не уверен), поэтому повторяем 2 и 3 шаг
5) Теперь наша статистика находиться на localhost/images (на localhost оставил дефолтный nginx)
6) Если захотите удалить и запустить заново, то не забудьте удалить последний ключ из .ssh/known_hosts

Использовал глобальную перенную vars.yml, т.к у нас 2 роли используют одни и те же данные (переменную shell). В роль package_install не стал добалять vars, т.к размер от этого не меняется, но как по мне ухудшается читаемость. Также я хотел использовать handler для nginx (Я оставил комментарий можно проверить на работу без контейнера), но тут происходит проблема, что первым запускается handler ssh, затем контейнер падает и когда снова запускается ansible-playbook playbook.yml, то он считает, что ничего не изменилось и не запускает handler nginx.
