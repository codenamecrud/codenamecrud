# Course.destroy_all
# Section.destroy_all
# Lesson.destroy_all

# user = User.new(
#     name: 'Frey',
#     email: "frey@list.ru",
#     password: "00000000",
#     password_confirmation: "00000000",
#     role: 'admin'
# )
# user.save!

# to avoid duplication
incrementer = 1000
Course.find_each { |c| c.update_attribute(:position, c.position + incrementer)}
Section.find_each { |s| s.update_attribute(:position, s.position + incrementer)}
Lesson.find_each { |l| l.update_attribute(:position, l.position + incrementer)}

course_position = 0
section_position = 0
lesson_position = 0

def create_or_update_course(course_attrs)
  course = Course.find_by(title: course_attrs[:title])
  if course.nil?
    course = Course.create!(course_attrs)
    puts ">>>> Создан новый курс: #{course_attrs[:title]}"
  elsif course.attributes == course_attrs
    puts "Существующий курс не изменен: #{course_attrs[:title]}"
  else
    course.update_attributes(course_attrs)
    puts "Обновлен существующий << КУРС >>: #{course_attrs[:title]}"
  end
  return course
end

def create_or_update_section(section_attrs)
  section = Section.find_by(title: section_attrs[:title], course: section_attrs[:course])
  if section.nil?
    section = Section.create!(section_attrs)
    puts ">>>> Создан новый РАЗДЕЛ: #{section_attrs[:title]}"
  elsif section.attributes == section_attrs
    puts "Существующий раздел не изменен: #{section_attrs[:title]}"
  else
    section.update_attributes(section_attrs)
    puts "Обновлен существующий РАЗДЕЛ: #{section_attrs[:title]}"
  end
  return section
end

def create_or_update_lesson(lesson_attrs)
  lesson = Lesson.find_by(title: lesson_attrs[:title], section: lesson_attrs[:section])

  # Need to create a new lesson!
  if lesson.nil?
    lesson = Lesson.create!(lesson_attrs)
    puts ">>>> Создан новый урок: #{lesson_attrs[:title]}"

  # Just need to update our lesson's attributes
  elsif lesson.attributes == lesson_attrs
    puts "Существующий урок не изменен: #{lesson_attrs[:title]}"
  else
    lesson.update_attributes(lesson_attrs)
    puts "Обновлен существующий урок: #{lesson_attrs[:title]}"
  end
  return lesson
end


# == Первый курс == #

course_position += 1
course = create_or_update_course(
  title: 'Введение в веб-разработку',
  slug: 'introduction-to-web-development',
  short_description: 'Этот короткий курс начнет обучение с нуля, ответит на стандартные задаваемые вопросы о практике и карьере в сфере веб-разработки. Вы получите намного лучшее представление о том, во что вы готовитесь погрузиться!',
  description: 'Этот короткий курс ответит на стандартные вопросы о практике и карьере в сфере веб-разработки. Даже если вы явно ощущаете, что программирование и путь веб-разработчика словно созданы для вас, вы, вероятно, всё еще не особо представляете, чем на самом деле занимаются разработчики... и это то, с чего начинают все, так что всё в порядке.',
  you_learn: ['Что на самом деле делают веб-разработчики', 'Рабочие инструменты', 'Как найти работу веб-разработчиком'],
  you_build: ['Не спешите, скоро вы приступите к практике!'],
  teaser: 'Начните отсюда!',
  position: course_position,
  is_active: true
  )

section_position += 1
section = create_or_update_section(
  title: 'О веб-разработчиках',
  slug: 'about-web-developers',
  position: section_position,
  description: 'Начните с начала и узнайте, чем на самом деле занимаются веб-разработчики и на что похожа сфера веб-разработки.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Чем занимается веб-разработчик',
  position: lesson_position,
  slug: 'what-a-web-developer-does',
  description: 'От того, чем на самом деле занимается разработчик к ключевым различиям вроде разделения на бэк-енд и фронт-енд, веб-разработчиков против веб-дизайнеров и веб-сайтов против веб-приложений',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/01_what_does_a_web_dev_do.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Работа и карьера в веб-разработке',
  position: lesson_position,
  slug: 'web-development-jobs-and-careers',
  description: 'Несколько кратких примеров ролей веб-разработчиков в различных организациях',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/02_web_dev_jobs.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Рабочие инструменты',
  position: lesson_position,
  slug: 'tools-of-trade',
  description: 'Обзор различных инструментов, испольуемых веб-разработчиками для выполнения своей работы',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/03_tools_of_trade.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Сообщества веб-разработчиков',
  position: lesson_position,
  slug: 'web-development-communities',
  description: 'Разработчики - на удивление социальная группа, и здесь вы узнаете, как найти их онлайн и лично',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/04_web_dev_communities.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Лучшие веб-разработчики',
  position: lesson_position,
  slug: 'the-best-web-developers',
  description: 'Несколько советов о том, что делает веб-разработчика великим',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/05_the_best_web_devs.md'
  )


lesson_position += 1
create_or_update_lesson(
  title: 'Ищем работу в качестве веб-разработчика',
  position: lesson_position,
  slug: 'getting-hired-as-a-web-developer',
  description: 'Кратко проясняем, что на самом деле хотят получить работодатели от веб-разработчика и как может выглядеть процесс найма',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/06_getting_hired_as_a_web_dev.md'
  )


lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'conclusion',
  description: 'Общий взгляд на предстоящее путешествие вниз по кроличьей норе',
  is_project: false,
  section: section,
  course: course,
  url: '/introduction_to_web_development/07_conclusion.md'
  )

# == Второй курс == #

course_position += 1
course = create_or_update_course(
  title: 'Основы веб-разработки',
  slug: 'basics-of-web-development',
  short_description: 'Этот курс для всех, кто начинает с нуля или не совсем комфортно чувствует себя при работе с командной строкой, HTML, CSS, Javascript, Ruby, веб-фреймворками, Git или другими базовыми технологиями веб-разработки. Мы покроем МНОЖЕСТВО тем -- к концу этого объемного курса вы будете готовы к изучению наших более углубленных курсов или продолжать исследования самостоятельно.',
  description: 'Теперь вы знаете, чем занимаются веб-разработчики, настало время подумать о том, как они этим занимаются. В этом курсе вы изучите базовые концепции веб-программирования. К его завершению вы будете способны собрать простую веб-страницу, стилизовать её, добавить интерактивные элементы и чувствовать себя комфортно при работе с командной строкой. Вы попрактикуетесь в написании простых скриптов на Ruby и Javascript, а так же познакомитесь с такими вещами, как Git и базы данных. Вы получите множество новых знаний и будете готовы "замарать руки" в практическом применении этих знаний во всех темах, которые мы будем изучать в последующих углубленных курсах.',
  you_learn: ['Как на самом деле работает Веб', 'Основы HTML, CSS и Javascript', 'Основы Ruby, Rails, Git и баз данных'],
  you_build: ['Главная страница Google на HTML/CSS', 'Динамический блокнот на JS/jQuery', 'Серия испытаний на Ruby по принципу "Тесты вперед"'],
  teaser: 'Здоровая порция всего необходимого',
  position: course_position,
  is_active: true
  )

# == Первый раздел == #

section_position += 1
section = create_or_update_section(
  title: 'Основы',
  slug: 'the-basics',
  position: section_position,
  description: 'Этот раздел покроет базовые знания, которые вам необходимо иметь, прежде чем окунуться в более "программные" аспекты веб-разработки. Так же вы научитесь устанавливать необходимое программное обеспечение на ваш компьютер.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как работает этот курс',
  position: lesson_position,
  slug: 'how-this-course-will-work',
  description: 'Прежде, чем окунуться в обучение, ознакомьтесь с тем, что вас ждет',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/01_how_this_course_will_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как работает Сеть',
  position: lesson_position,
  slug: 'how-does-the-web-work',
  description: 'Трудно будет заниматься веб-разработкой без понимания, как работает Интернет',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/02_how_does_the_web_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как работает ваш компьютер',
  position: lesson_position,
  slug: 'how-does-your-computer-work',
  description: 'Командная строка: любима, ненавидима, пугающа... Но это уже не про вас.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/03_how_does_your_computer_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Необходимые термины',
  position: lesson_position,
  slug: 'terms-to-know',
  description: 'Краткое описание терминов, которые необходимо понимать, прежде чем двигаться дальше',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/04_terms_to_know.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: установки',
  position: lesson_position,
  slug: 'project-installations',
  description: 'Несколько вещей, которые необходимо установить, прежде чем начать писать код',
  is_project: true,
  section: section,
  course: course,
  url: '/web_development_101/05_project_installations.md'
  )

# == Второй раздел == #

section_position += 1
section = create_or_update_section(
  title: 'Фронтенд',
  slug: 'frontend',
  position: section_position,
  description: 'В этом разделе вы потратите изрядное количество времени, знакомясь с основными (браузерными) языками HTML, CSS и Javascript. Вы создадите веб-страницу при помощи HTML и CSS и изучите основы программирования на Javascript.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Введение в фронтенд',
  position: lesson_position,
  slug: 'introduction-to-the-frontend',
  description: 'Краткий обзор на то, чем вообще является "Фронтенд"',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/06_introduction_to_the_front_end.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы HTML и CSS',
  position: lesson_position,
  slug: 'html-and-css-basics',
  description: 'Вы узнаете, как создают веб-страницы и настраивают их внешний вид при помощи HTML и CSS',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/07_html_css_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: HTML и CSS',
  position: lesson_position,
  slug: 'project-html-css',
  description: 'Настало время применить полученные знания. Создавайте!',
  is_project: true,
  section: section,
  course: course,
  url: '/web_development_101/08_project_html_css.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы Javascript',
  position: lesson_position,
  slug: 'javascript-basics',
  description: 'Вы изучите основы программирования, которые пригодятся вам для того, чтобы сделать страницу динамической',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/09_javascript_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы jQuery',
  position: lesson_position,
  slug: 'jquery-basics',
  description: 'Вы узнаете, как использовать ваши знания в Javascript для легкого и удобного применения их в работе над веб-страницами ',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/10_jquery_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Javascript и jQuery',
  position: lesson_position,
  slug: 'project-javascript-and-jquery',
  description: 'Создайте собственную "рисовалку"',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/11_project_js_jquery.md'
  )

# == Третий раздел == #

section_position += 1
section = create_or_update_section(
  title: 'Бэкенд',
  slug: 'backend',
  position: section_position,
  description: 'Здесь вы узнаете о бэкенде, мы раскроем все, что скрывается за кулисами веб-сервера. Вы попробуете на вкус Ruby, чертовски классный язык, на котором написан фреймворк Ruby on Rails',
  course: course
)

lesson_position += 1
create_or_update_lesson(
  title: 'Введение в бэкенд',
  position: lesson_position,
  slug: 'introduction-to-the-backend',
  description: 'Краткое введение в чудесный мир серверного программирования',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/12_introduction_to_the_back_end.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы Ruby',
  position: lesson_position,
  slug: 'ruby-basics',
  description: 'Добротное погружение в Ruby, вы потратите некоторое время на изучение основ этого дружественного к программисту языка',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/13_ruby_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы тестирования',
  position: lesson_position,
  slug: 'testing-basics',
  description: 'Краткое введение в тестирование в общем и в RSpec, "язык" для тестирования Ruby',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/14_testing_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Ruby',
  position: lesson_position,
  slug: 'project-ruby',
  description: 'Время применить то, что вы изучили о Ruby, заставив тесты проходить в нескольких уроков, от простых до сложных',
  is_project: true,
  section: section,
  course: course,
  url: '/web_development_101/15_project_ruby.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Базы данных',
  position: lesson_position,
  slug: 'databases',
  description: 'Последний фундаментальный компонент - это то, как "сохранять" ваши данные, используя базы данных. Вы изучите основы SQL, языка, используемого для общения с большинством реляционных баз данных.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/16_database_basics.md'
  )

# == Четвертый раздел == #


section_position += 1
section = create_or_update_section(
  title: 'Фреймворки для веб-разработки',
  position: section_position,
  slug: 'web-development-frameworks',
  description: 'Вы скорее всего слышали о "Ruby on Rails" и "Backbone.js", а так же о других приятно звучащих фреймворках для разработки. В этом разделе вы узнаете, что такое фреймворк, почему мы их используем и освоитесь с теми, знание которых нам потребуется в последующих курсах.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Введение в фреймворки',
  position: lesson_position,
  slug: 'introduction-to-frameworks',
  description: 'Давайте узнаем, что это за штуки.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/17_introduction_to_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы Ruby on Rails',
  position: lesson_position,
  slug: 'ruby-on-rails-basics',
  description: 'Вы узнаете основы невероятно популярного фреймворка, благодаря которому тысячи программистов любят свою работу.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/18_rails_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Ruby on Rails',
  position: lesson_position,
  slug: 'project-ruby-on-rails',
  description: 'Вы изучили основы, теперь давайте применим эти знания, создав простое приложение.',
  is_project: true,
  section: section,
  course: course,
  url: '/web_development_101/19_project_rails.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Backbone.js',
  position: lesson_position,
  slug: 'backbone-js',
  description: 'Краткое ознакомление с Backbone.js, популярным фронтенд-фреймворком, которые будет более детально рассмотрен в одном из последующих курсов',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/20_backbone_basics.md'
  )

# == Пятый раздел == #


section_position += 1
section = create_or_update_section(
  title: 'Дополнительные важные темы',
  position: section_position,
  slug: 'additional-important-topics',
  description: 'Этот раздел содержит набор коротких уроков, которые позволят вам освоиться с основами нескольких сопутствующих технологий, умение работать с которыми потребуется вам на вашем пути к карьере веб-разработчика.',
  course: course
  )


lesson_position += 1
create_or_update_lesson(
  title: 'Основы Git',
  position: lesson_position,
  slug: 'git-basics',
  description: 'Git является системой контроля версий, используемой разработчиками... это как "сохранение" плюс "машина времени".',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/21_git_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Облака, хостинг и софт как услуга (SaaS)',
  position: lesson_position,
  slug: 'the-cloud-hosting-and-software-as-a-service-saas',
  description: 'Настало время познакомить вас с некоторыми важными терминами, которые вы могли слышать, и рассказать, почему вам важно знать их и использовать то, что они означают.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/22_the_cloud_hosting_and_saas.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Безопасность, SSL и лучшие практики',
  position: lesson_position,
  slug: 'security-ssl-and-best-practices',
  description: 'Краткое введение в концепцию безопасности и лучшие практики в этой области.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/23_security_ssl_and_best_practices.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы FTP',
  position: lesson_position,
  slug: 'ftp-basics',
  description: 'Очень краткий обзор Протокола Передачи Файлов (FTP), который часто используется для загрузки файлов на сервер.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/24_ftp_basics.md'
  )


section_position += 1
section = create_or_update_section(
  title: 'Собираем все воедино',
  slug: 'tying-it-all-togerher',
  position: section_position,
  description: 'Теперь вы знаете о большинстве компонентов веб-приложений, стоит отступить на шаг назад и вспомнить, как они укладываются в большую картинку.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как создаются сайты в реальном мире?',
  position: lesson_position,
  slug: 'how-are-websites-built-in-the-real-world',
  description: 'Взгляд на более общую картину того, как выглядит процесс разработки сайта и детальный взгляд на то, что именно делает разработчик.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/25_how_are_websites_built.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Принципы хорошего программирования',
  position: lesson_position,
  slug: 'principles-of-good-programming',
  description: 'Обзор некоторых важнейших принципов, важных к пониманию, чтобы быть хорошим программистом. Кратко: будьте ленивы.',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/26_principles_of_good_programming.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'conclusion',
  description: 'Как далеко вы уже зашли! Но поездка только начинается...',
  is_project: false,
  section: section,
  course: course,
  url: '/web_development_101/27_conclusion.md'
  )


# = Третий курс = #

course_position += 1
create_or_update_course(
  title: 'Программирование на Ruby',
  slug: 'ruby-programming',
  short_description: 'Когда вы завершили курс "Основы веб-разработки", этот курс погрузит вас в чудесный мир Ruby. Вы изучите комбинацию из основ программирования и лучших практик, а так же получите возможность создать несколько разных проектов по мере прохождения курса.',
  description: 'В этом курсе вы изучите Ruby, язык, специально разработанный так, чтобы на нем было приятно писать. К его завершению вы создадите несколько довольно интересных проектов, включая Тик Так, Висельника, реальный веб-сервер и Шахматы. Вы научитесь собирать спамбота для Twitter (он реально спамит!), сохранять и открывать файлы, тестировать код, разделите ваш спагетти-код на отдельные классы и даже воспроизведете некоторые базовые алгоритмы и структуры данных для решения сложных проблем. В общем, начнете чувствовать себя намного более "программистом", и это будет справедливое чувство.',
  you_learn: ['Как писать чистый, эффективный и модульный код', 'Работа с файлами и скриптами', 'Базовые алгоритмы и структуры данных'],
  you_build: ['Тиктак, Быки и Коровы, Висельник', 'Сервер для командной строки и браузер', 'Шахматы (серьезно)'],
  teaser: 'Скоро будет доступно!',
  position: course_position,
  is_active: false
  )


# = Четвертый курс = #

course_position += 1
create_or_update_course(
  title: 'Ruby on Rails',
  slug: 'ruby-on-rails',
  short_description: 'Теперь, когда вы освоились с Ruby, настало время применить эти знания и узнать, как быстро создавать веб-сайты, используя Ruby on Rails. К концу этого курса вы сможете уверенно создать и развернуть реальный веб-сайт. Собственно, вы проделаете это множество раз.',
  description: 'В этом курсе вы будете постоянно писать код, каждый проект будет чуть более продвинутым, чем предыдущий. Вы создадите кучу Rails-проектов с нуля, включая один полноценный туториал, через который мы пройдем, и собственное полномасштабное Rails-приложение. Что более важно, вы узнаете, как разобрать сайт на данные и архитектуру, а затем построить вокруг них приложение. В конце концов вы обретете уверенность и знания, которых будет достаточно, чтобы создать простой веб-сайт примерно за час.',
  you_learn: ['Как создать и развернуть веб-приложение с нуля', 'MVC как свои пять пальцев', 'Разработка архитектуры для нового сайта'],
  you_build: ['Полноценный клон Twitter', 'Приложение для заказа авиабилетов', 'Куча другого, с простых приложений до API и Facebook'],
  teaser: 'Скоро будет доступно!',
  position: course_position,
  is_active: false
  )


# = Пятый курс = #

course_position += 1
create_or_update_course(
  title: 'HTML5 и CSS3',
  slug: 'html5-and-css3',
  short_description: 'Теперь вы профессионал в создании бэкенда для сайта, настало время как следует вникнуть в фронтенд, чтобы ваши сайты перестали быть уродливыми и вы начали понимать DOM. Этот короткий курс даст вам инструменты для прекращения борьбы с вашим CSS и начала создания более логично выглядящих сайтов.',
  description: 'В этом курсе вы преодолеете свой страх перед CSS и начнете понимать некоторые из фундаментальных принципов хорошего дизайна сайтов. Это не полный курс по фронтенд-дизайну, но он должен дать вам инструменты, которые понадобятся для глубокого понимания CSS-фреймворков и для создания приятно выглядящего фасада к вашему гениальному бэкенду.',
  you_learn: ['Все о стилизации при помощи CSS', 'Как эффективно использовать фронтенд-фреймворк вроде Bootstrap', 'Базовые принципы разметки и дизайна сайта'],
  you_build: ['Визуальные копии нескольких популярных сайтов', 'Свой собственный фронтенд-фреймворк', 'Охапку CSS-трюков и тактик'],
  teaser: 'Скоро будет доступно!',
  position: course_position,
  is_active: false
  )



# = Шестой курс = #

course_position += 1
create_or_update_course(
  title: 'Javascript и jQuery',
  slug: 'Javascript-and-jquery',
  short_description: 'Последний компонент в вашем арсенале веб-разработчика -- это умение научить ваш фронтенд динамически реагировать на действия пользователя. В этом курсе вы узнаете, как использовать Javascript и jQuery для взаимодействия с DOM и как делать вещи вроде выпадающих меню, параллакс-эффекта при прокрутке, одностраничных приложений и даже игр. Это свяжет все изученное ранее воедино в один прекрасный комплект.',
  description: 'Javascript прямо сейчас захватывает мир -- веб-приложения становятся все более и более завязанными на фронтенд. Хотя JS пока чаще всего используется для анимации выпадающих меню и валидации форм, он (при некоторой помощи магии jQuery) вырос в инструмент для создания полноценных фронтенд-приложений, включая одностраничные.',
  you_learn: ['Как создавать интерактивные игры при помощи HTML5 canvas', 'Как использовать весь набор jQuery-эффектов на DOM', 'Как организовать ваш JS-код в модульные части'],
  you_build: ['Javascript-фронтенд для вашего Rails-бэкенда', 'Собственный Javascript-фреймворк', 'Змейку, Ракеты и многое другое'],
  teaser: 'Скоро будет доступно!',
  position: course_position,
  is_active: false
  )

# = Седьмой курс = #

course_position += 1
create_or_update_course(
  title: 'Ищем работу в качестве веб-разработчика',
  slug: 'getting-hired-as-a-web-developer',
  short_description: 'Вы зашли чертовски далеко и готовы работать веб-разработчиком, но, как вы могли понять, дорога открытий лишь начинается. К счастью, теперь вы достаточно полезны, чтобы другие платили вам за то, что вы будете продолжать создавать и обучаться... и в этом коротком курсе мы покажем, как этого добиться.',
  description: 'Вы все еще имеете кучу времени, чтобы учиться (это действительно путешествие длинной в жизнь), но сейчас лучший способом заниматься обучением - окружить себя отличными разработчиками. Этот курс полностью посвящен следующему шагу -- что еще вам нужно знать, где искать работу, как проходить интервью и как, в конце концов, получить предложение о работе.',
  you_learn: ['Где найти подходящие объявления о найме', 'Как эффективно продавать себя нанимателям', 'Как проходить технические интервью'],
  you_build: ['Ваш собственный сайт-портфолио', 'Базовые знания о навыках, необходимых для решения более сложных проблем', 'Четкая стратегия, как быть нанятым'],
  teaser: 'Скоро будет доступно!',
  position: course_position,
  is_active: false
  )
