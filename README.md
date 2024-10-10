Предварительные требования:
- linux или macos
- python3.12 + passlib (можете изменить на свою версию в inventory.ini)
- ansible
- docker
- ssh

Порядок запуска:
1) Создать test.key (private key) для inventory.ini и test.pub (public key) для Dockerfile, в корневой папке (у меня они в .gitignore)
2) docker compose up -d
3) ansible-playbook playbook.yml
5) Теперь наша статика находиться на localhost/images (на localhost оставил дефолтный nginx)
6) Если захотите удалить и запустить заново, то не забудьте удалить последние ключи из .ssh/known_hosts или добавить host_key_checking = False в ansible.cfg

В контейнер я добавил второй процесс, чтобы при перезапуске ssh он не падал. Использовал глобальную перенную vars.yml, т.к у нас 2 роли используют одни и те же данные (переменную shell). В роль package_install не стал добалять vars, т.к размер от этого не меняется, но как по мне ухудшается читаемость. 
