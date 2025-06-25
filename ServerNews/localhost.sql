-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Июн 24 2025 г., 14:32
-- Версия сервера: 10.6.22-MariaDB-cll-lve
-- Версия PHP: 8.3.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `winkera5_newsDB`
--
CREATE DATABASE IF NOT EXISTS `winkera5_newsDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `winkera5_newsDB`;

-- --------------------------------------------------------

--
-- Структура таблицы `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `articles`
--

INSERT INTO `articles` (`id`, `title`, `content`, `image`, `github`, `created_at`) VALUES
(1, 'Машинное обучение', 'Вступление\r\nМашинное обучение (МО) — это область знаний и исследований в области искусственного интеллекта, которая занимается разработкой алгоритмов и статистических моделей, которые могут аппроксимировать данные, обучаться на них, обобщать их на невидимые зависимости и, таким образом, выполнять задачи без явных инструкций.\r\n\r\nМашинное обучение является ключевой компонентой ИИ, которая позволяет компьютерным программам выполнять задачи без явного программирования, вместо этого полагаясь на закономерности и зависимости, выведенные из данных. Это направление в ИИ, основано на идее того, что системы могут учиться на данных, выявлять закономерности и принимать решения с минимальным вмешательством человека.\r\n\r\nМашинное обучение можно применять в решении различных задач. Предсказывать значения определенной величины на основе набора данных. Использовать на веб-сайтах для рекомендации контента или продуктов. Помогать выявлять аномалии в финансовых транзакциях и предсказывать рыночные тенденции. Распознавать какие-либо объекты и благодаря этому принимать решения.\r\n\r\nВ целом, машинное обучение позволяет компьютерным системам обучаться и адаптироваться к новым данным, что делает его мощным инструментом в различных областях.\r\n\r\nОсновные концепции.\r\nМодель МО — совокупность алгоритмов, параметров и структур данных, которые обеспечивают работу и обучение модели путем изменения ее параметров определенным образом. Другими словами, это система, которая изменяет значения своих параметров, тем самым изменяя свое преобразование входных данных в выходные.\r\n\r\nГоворя о модели машинного обучения, я имею в виду понятие, которое обозначает не только ту часть модели, которая представляет собой конечную обученную модель и отвечает за вывод (inference), а также и все остальные части, которые участвуют в обучении и процессе обработки данных.', 'images/project1.jpg', 'https://github.com/WinkerAs/bot-tel', '2025-01-30 20:34:11'),
(2, 'Веб-приложение на React', 'Текст второй статьи...', 'images/project2.jpg', 'https://github.com/user/project2', '2025-01-30 20:34:11'),
(3, 'База знаний', 'База знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знанийБаза знаний', 'images/project3.jpg', 'github.com', '2025-02-02 15:11:36');

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(4, 'Entertainment'),
(3, 'Sports'),
(2, 'Technology'),
(1, 'World');

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `image_url`, `category_id`, `created_at`) VALUES
(1, 'Global Event Today', 'Details about the global event...', 'https://avatars.mds.yandex.net/i?id=9acc8ee304131eefcd5543a1354bc72ba9527809-5284808-images-thumbs&n=13', 1, '2025-06-24 09:32:50'),
(2, 'New Smartphone Released', 'Specs and review...', 'https://example.com/images/smartphone.jpg', 2, '2025-06-24 09:32:50'),
(3, 'Championship Results', 'Match summary...', 'https://example.com/images/championship.jpg', 3, '2025-06-24 09:32:50'),
(4, 'Movie Premiere Highlights', 'Red carpet and stars...', 'https://example.com/images/movie_premiere.jpg', 4, '2025-06-24 09:32:50');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`) VALUES
(1, 'Victor', '$2y$10$rYH6Zxqqm7us6zl4CeXuq.T4yFtPfgvrR5jGtQ9I0PRReoFFJmxiK', '2025-06-24 10:14:56');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
