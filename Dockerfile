# Используем официальный образ Flutter
FROM cirrusci/flutter:stable

# Устанавливаем нужную версию Dart SDK
RUN flutter --version

# Создаем нового пользователя для работы
RUN useradd -ms /bin/bash flutteruser

# Переключаемся на пользователя root для изменения прав доступа
USER root

# Даем права на весь каталог Flutter SDK, включая кеш
RUN chown -R flutteruser:flutteruser /sdks/flutter

# Переключаемся обратно на пользователя flutteruser
USER flutteruser

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем все файлы проекта в контейнер
COPY . /app

# Добавляем путь к Flutter SDK в безопасные директории
RUN git config --global --add safe.directory /sdks/flutter

# Обновляем зависимости (flutter pub get)
RUN flutter pub get

# Сборка Flutter-приложения для Linux
RUN flutter build linux --release

# Устанавливаем порт, если необходимо для работы приложения
EXPOSE 8080

# Указываем команду для запуска приложения
CMD ["flutter", "run", "linux"]
