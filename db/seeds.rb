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
Course.find_each { |c| c.update_attribute(:position, c.position + incrementer) }
Section.find_each { |s| s.update_attribute(:position, s.position + incrementer) }
Lesson.find_each { |l| l.update_attribute(:position, l.position + incrementer) }

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
  course
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
  section
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
  lesson
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
  title: 'Проект: Установки',
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
  is_project: true,
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
course = create_or_update_course(
  title: 'Программирование на Ruby',
  slug: 'ruby-programming',
  short_description: 'Когда вы завершили курс "Основы веб-разработки", этот курс погрузит вас в чудесный мир Ruby. Вы изучите комбинацию из основ программирования и лучших практик, а так же получите возможность создать несколько разных проектов по мере прохождения курса.',
  description: 'В этом курсе вы изучите Ruby, язык, специально разработанный так, чтобы на нем было приятно писать. К его завершению вы создадите несколько довольно интересных проектов, включая Крестики-нолики, Висельника, реальный веб-сервер и Шахматы. Вы научитесь собирать спамбота для Twitter (он реально спамит!), сохранять и открывать файлы, тестировать код, разделите ваш спагетти-код на отдельные классы и даже воспроизведете некоторые базовые алгоритмы и структуры данных для решения сложных проблем. В общем, начнете чувствовать себя намного более "программистом", и это будет справедливое чувство.',
  you_learn: ['Как писать чистый, эффективный и модульный код', 'Работа с файлами и скриптами', 'Базовые алгоритмы и структуры данных'],
  you_build: ['Тиктак, Быки и Коровы, Висельник', 'Сервер для командной строки и браузер', 'Шахматы (серьезно)'],
  teaser: 'Станьте настоящим рубистом!',
  position: course_position,
  is_active: true
  )

# = Первый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Основы Ruby',
  position: section_position,
  slug: 'basic-ruby',
  description: 'В этом разделе мы изучим основные темы в Ruby и немного попрактикуемся. Все остальное, что вы изучите в программировании, основывается на эти концепциях, так что вы получите полезнейший опыт, который пригодится вам при работе с другими проектами и языками в будущем.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как будет работать этот курс',
  position: lesson_position,
  slug: 'ruby-how-this-course-will-work',
  description: 'Настало время познакомиться с тем, как все выглядит изнутри.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/01_how_this_course_will_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как будет работать этот курс',
  position: lesson_position,
  slug: 'ruby-how-this-course-will-work',
  description: 'Настало время познакомиться с тем, как все выглядит изнутри.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/01_how_this_course_will_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Строительные блоки Ruby',
  position: lesson_position,
  slug: 'ruby-building-blocks',
  description: 'Более глубокий взгляд на основы Ruby: переменные, типы данных, строки и методы',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/02_building_blocks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Строительные блоки',
  position: lesson_position,
  slug: 'project-building-blocks',
  description: 'Настало время привыкать писать скрипты без подстраховки.',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/03_project_building_blocks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Продвинутые строительные блоки Ruby',
  position: lesson_position,
  slug: 'advanced-ruby-building-blocks',
  description: 'Мы продолжаем путешествие в основы, в этот раз это управление потоком, циклы, массивы, хэши, блоки и сортировка',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/04_advanced_building_blocks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Продвинутые строительные блоки',
  position: lesson_position,
  slug: 'project-advanced-building-blocks',
  description: 'Вы можете применить изученное на практике, создав простой шифр и воссоздав методы Enumerable, которые постоянно будут использоваться позднее.',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/05_project_advanced_building_blocks.md'
  )

# = Второй раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Средний уровень Ruby',
  position: section_position,
  slug: 'intermediate-ruby',
  description: 'Теперь в вашем ящике инструментов на Ruby уже что-то есть и сейчас самое время создать с их помощью что-то полезное. В этом разделе вы узнаете, как рассортировать ваш спагетти-код в разумно организованные методы и классы. Так же вы научитесь сериализовать код и сохранять его в файлах.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Объектно-ориентированное программирование',
  position: lesson_position,
  slug: 'object-oriented-programming',
  description: 'Фундаментальные концепции объектно-ориентированного программирования, которые пригодятся вам в любом языке программирования.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/06_oop.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: ООП',
  position: lesson_position,
  slug: 'project-oop',
  description: 'Разомнем мышцы, создав "Крестики-нолики" и "Mastermind" для командной строки',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/07_project_oop.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Файлы и сериализация',
  position: lesson_position,
  slug: 'files-and-serialization',
  description: 'Что, если вы захотите сохранить состояние вашей программы? Как насчет загрузки её в файл? Здесь вы узнаете о некоторых базовых операциях вроде этой.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/08_serialization.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: File I/O и сериализация',
  position: lesson_position,
  slug: 'project-file-i-o-and-serialization',
  description: 'Вы сможете поработать с существующими данными а затем со словарями, написав "Висельника"',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/09_project_file_io.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Ruby в Сети',
  position: section_position,
  slug: 'ruby-on-the-web',
  description: 'Этот короткий раздел заполнит пустоту между тем, что вы делали в командной строке и диким миром Интернета... Как автоматизировать отправку твитов? Как насчет создания собственного веб-сервера?',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Выводим Ruby в Сеть',
  position: lesson_position,
  slug: 'bringing-ruby-online',
  description: 'Пересечение Ruby и HTTP... суперсилы продаются отдельно.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/10_bringing_ruby_online.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Ruby в Сети',
  position: lesson_position,
  slug: 'project-ruby-on-the-web',
  description: 'Хотели когда-нибудь заспамить своих читателей в Twitter? Как насчет того, чтобы создать собственный простой веб-сервер? Когда, если не сейчас...',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/11_project_web.md'
  )

# = Четвертый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Немного Компьютерных Наук',
  position: section_position,
  slug: 'ruby-on-the-web',
  description: 'В этом разделе вы узнаете некоторые фундаментальные концепты в информатике, которые помогут вам, когда настанет время решать проблемы чуть более сложные, чем просто обслуживание веба. Вы примерите на себя роль инженера и решите некоторые интересные задачи.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Очень краткое введение в информатику',
  position: lesson_position,
  slug: 'a-very-brief-intro-to-cs',
  description: 'Попробуйте на вкус то, что последует далее и поймите, насколько велик мир компьютерных наук за пределами этого курса.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/12_a_very_brief_intro_to_cs.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Рекурсивные методы',
  position: lesson_position,
  slug: 'recursive-methods',
  description: 'Узнайте, как вызов маленькой функции может быть полезен при разбиении большой задачи на несколько маленьких.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/13_recursion.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Рекурсия',
  position: lesson_position,
  slug: 'project-recursion',
  description: 'Возьмите свежеобретенные знания и примените их в решении пары классических рекурсивных проблем.',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/14_project_recursion.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основные структуры данных и алгоритмы',
  position: lesson_position,
  slug: 'common-data-structures-and-algorithms',
  description: 'Узнайте, почему мы используем разные структуры данных для хранения наших данных и прочтите о некоторых классических алгоритмах поиска по структурам данных, полезных для решения задач.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/15_data_structures_algorithms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Структуры данных и алгоритмы',
  position: lesson_position,
  slug: 'project-data-structures-and-algorithms',
  description: 'Если вы не уверены в том, что способны мыслить алгоритмически, здесь пара уроков, которые позволят вам использовать инструменты, разработанные вами ранее. Это так же может быть полезно, если подумать о Финальном проекте... подсказка-подсказка...',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/16_project_data_structures_algorithms.md'
  )

# = Пятый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Тестирование Ruby с помощью RSpec',
  position: section_position,
  slug: 'testing-ruby-with-rspec',
  description: 'Вам было дано краткое введение в тестирование на Ruby некоторое время назад в курс "Основы веб-разработки", а сейчас вы узнаете, почему тестирование может быть невероятно полезным и как использовать его в собственных проектах.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Введение в RSpec',
  position: lesson_position,
  slug: 'introduction-to-rspec',
  description: 'Многие современные технологические компании полагаются на методы разработки с использованием множества автоматических тестов, так что неплохо было бы с ними ознакомиться.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/17_introduction_to_rspec.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Тестирование Ruby',
  position: lesson_position,
  slug: 'project-testing-ruby',
  description: 'По-настоящему можно научиться лишь практикуясь, так что прыгнем в машину времени и напишем несколько тестов к нашим прежним наработкам.',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/18_project_testing.md'
  )

# = Шестой раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Git',
  position: section_position,
  slug: 'git',
  description: 'Вы уже должны иметь представление о стандартном рабочем процессе с использованием Git, поскольку вы применяли его для сохранения ваших проектов (верно?!). Этот раздел научит вас несколько более продвинутому использованию Git в работе.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Более глубокий взгляд на Git',
  position: lesson_position,
  slug: 'a-deeper-look-at-git',
  description: 'Немного дальше, чем `git add` и `git commit`.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/19_a_deeper_look_at_git.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Использование Git в реальном мире',
  position: lesson_position,
  slug: 'using-git-in-the-real-world',
  description: 'Мы увидели лишь макушку айсберга, но здесь вы сможете узнать о вещах, которые пригодятся вам, когда вы станете использовать Git все чаще и чаще.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/20_using_git_in_the_real_world.md'
  )

# = Седьмой раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Заключение',
  position: section_position,
  slug: 'ruby-conclusion',
  description: 'Вы уже прошли невероятно длинный путь, теперь необходимо объединить все изученное в один прочный пласт знаний и создать нечто реальное. Это ваш финальный экзамен и большое перо для вашей шляпы. Завершив этот раздел, вы будете знать достаточно много, чтобы взяться практически за что угодно.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Финальный проект на Ruby',
  position: lesson_position,
  slug: 'project-ruby-final-project',
  description: 'Теперь было бы здорово вспомнить, как играть в шахматы. Или создать их самим, это еще интереснее (и приносит кучу удовольствия)!',
  is_project: true,
  section: section,
  course: course,
  url: '/ruby/21_project_final.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'conclusion-ruby',
  description: 'Вау! Вы сделали это! Давайте на минутку обернемся назад и рассмотрим изученное в контексте последующих шагов.',
  is_project: false,
  section: section,
  course: course,
  url: '/ruby/22_conclusion.md'
  )

# = Четвертый курс = #

course_position += 1
course = create_or_update_course(
  title: 'Ruby on Rails',
  slug: 'ruby-on-rails',
  short_description: 'Теперь, когда вы освоились с Ruby, настало время применить эти знания и узнать, как быстро создавать веб-сайты, используя Ruby on Rails. К концу этого курса вы сможете уверенно создать и развернуть реальный веб-сайт. Собственно, вы проделаете это множество раз.',
  description: 'В этом курсе вы будете постоянно писать код, каждый проект будет чуть более продвинутым, чем предыдущий. Вы создадите кучу Rails-проектов с нуля, включая один полноценный туториал, через который мы пройдем, и собственное полномасштабное Rails-приложение. Что более важно, вы узнаете, как разобрать сайт на данные и архитектуру, а затем построить вокруг них приложение. В конце концов вы обретете уверенность и знания, которых будет достаточно, чтобы создать простой веб-сайт примерно за час.',
  you_learn: ['Как создать и развернуть веб-приложение с нуля', 'MVC как свои пять пальцев', 'Разработка архитектуры для нового сайта'],
  you_build: ['Полноценный клон Twitter', 'Приложение для заказа авиабилетов', 'Куча другого, с простых приложений до API и Facebook'],
  teaser: 'Создаем настоящие сайты',
  position: course_position,
  is_active: true
  )

# = Первый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Введение в Rails',
  position: section_position,
  slug: 'introduction-to-rails',
  description: 'В этом разделе мы познакомимся с Rails и начнем с самого начала, чтобы у вас сложилось представление о том, что (и как) вы будете изучать, продвигаясь вперед. Мы зададим начальное направление.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как будет работать этот курс',
  position: lesson_position,
  slug: 'rails-how-this-course-will-work',
  description: 'Давайте посмотрим, что мы будем изучать.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/01_how_this_course_will_work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Первые шаги',
  position: lesson_position,
  slug: 'getting-your-feet-wet',
  description: 'Здесь мы создадим первое приложение на Rails, используя некоторые из предоставляемых нам фреймворком инструменты.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/02_project_feet_wet.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Памятка по Rails',
  position: lesson_position,
  slug: 'a-railsy-web-refresher',
  description: 'Мы не просто используем Сеть, мы живем в ней. Этот урок поможет вам освоиться с терминами.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/03_web_refresher.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Деплой',
  position: lesson_position,
  slug: 'deployment',
  description: 'Мало что сравниться с ощущением, которые испытываешь, видя свое приложение доступным в Сети. Мы покажем, как это можно осуществить.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/04_deployment.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Начнем создавать',
  position: lesson_position,
  slug: 'lets-get-building',
  description: 'В этом проекте вы начнете изучать руководство, которому мы будем следовать на протяжении всего курса.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/05_project_lets_build.md'
  )

# = Второй раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Маршрутизация, вьюхи, контроллеры и ассеты',
  position: section_position,
  slug: 'routes-views-conrollers-and-assets',
  description: 'Теперь, когда вы поняли, чем нам предстоит заниматься, настало время детально рассмотреть фундаментальные понятия фреймворка Ruby on Rails. Мы пройдем путь от HTTP-запроса до получения результата в виде HTML-страницы в браузере.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Маршрутизация (роутинг)',
  position: lesson_position,
  slug: 'routing',
  description: 'Роутер - это распределительный щит вашего приложения, направляющий запросы в соответствующие контроллеры.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/06_routing.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Контроллеры',
  position: lesson_position,
  slug: 'controllers',
  description: 'Контроллеры являются посредниками в процессе обработки запроса. Они говорят всем остальным, что делать и собирают полученный результат воедино.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/07_controller_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Вьюхи (представления)',
  position: lesson_position,
  slug: 'views',
  description: 'Когда контроллер определяет, какие данные нужно отобразить, настает время для работы Представлений (или вьюх). Они отвечают за отображение обработанных данных в браузере пользователя.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/08_views.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'The Asset Pipeline',
  position: lesson_position,
  slug: 'the-asset-pipeline',
  description: 'Этот урок объясняет, как Rails управляет вещами незримо для пользователя, чтобы вернуть в его браузер CSS, Javascript и изображения быстро и эффективно. Так же мы расскажем, как вам работать с этим процессом.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/09_asset_pipeline.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Основы маршрутизации, контроллеров и вьюх',
  position: lesson_position,
  slug: 'basic-routes-views-and-controllers',
  description: 'Вы поиграетесь с роутингом и на практике опробуете все, что успели изучить.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/10_project_basic_rvc.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Базы данных и Active Record',
  position: section_position,
  slug: 'databases-and-active-record',
  description: 'Этот раздел расскажет о серверной части Rails, которая является самой важной во всем фреймворке. Вы узнаете о базах данных и глубже погрузитесь в SQL, прежде чем применять знания к восхитительному гему Rails, который называется Active Record.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Базы данных и SQL',
  position: lesson_position,
  slug: 'databases-and-sql',
  description: 'Данные - это ядро любого крупного веб-приложения и в этом уроке вы научитесь говорить на SQL.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/11_databases.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: SQL',
  position: lesson_position,
  slug: 'project-sql',
  description: 'Лучший способ обучения - практика, и этот проект даст вам отличную возможность применить ваше знание SQL (во имя добра).',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/12_project_databases.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы ActiveRecord',
  position: lesson_position,
  slug: 'active-record-basics',
  description: 'Active Record - жемчужина в короне Rails, поскольку обращает голые и некрасивые запросы на SQL в удобные и читабельные методы на Ruby.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/13_active_record_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Практика с Active Record',
  position: lesson_position,
  slug: 'project-building-with-active-record',
  description: 'Лучший способ обучения - практика, и этот проект даст вам отличную возможность применить ваше знание SQL (во имя добра).',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/14_project_active_record.md'
  )

# = Четвертый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Формы и аутентификация',
  position: section_position,
  slug: 'forms-and-authentification',
  description: 'Этот раздел расскажет о некоторых частях веб-приложений, которые являются гораздо более важными, чем может показаться на первый взгляд. Формы - это способ пользователя взаимодействовать с приложением. Аутентификация критична для множества приложений, и вы создадите пару систем аутентификации с нуля.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы форм',
  position: lesson_position,
  slug: 'form-basics',
  description: 'Отчасти памятка, отчасти источник новых знаний, этот урок заполнит пробел в знаниях о взаимодействии форм и бэкенда.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/15_form_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: формы',
  position: lesson_position,
  slug: 'project-forms',
  description: 'Чтобы получить понимание форм, нужно начать с самого начала. Мы начнем с HTML и затем посмотрим, как нам пригодится Rails.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/16_project_forms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Сессии, cookies и аутентификация',
  position: lesson_position,
  slug: 'sessions-cookies-and-authentication',
  description: 'Узнайте, как хранить данные в браузере пользователя и как они используются при регистрации и входе пользователя между запросами.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/17_sessions_cookies_authentication.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Аутентификация',
  position: lesson_position,
  slug: 'project-authentification',
  description: 'Вы создадите закрытое сообщество, позволяющее анонимно делиться сплетнями с миром.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/18_project_auth.md'
  )

# = Пятый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Продвинутые формы и Active Record',
  position: section_position,
  slug: 'advanced-forms-and-active-record',
  description: 'Становится интереснее! Узнайте, как делать что-то большее, чем просто находить и показывать пользователей... вы узнаете о том, как использовать отношения между моделями, чтобы значительно расширить свои возможности и о том, как создавать формы, позволяющие достигнуть ваших целей.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Запросы Active Record',
  position: lesson_position,
  slug: 'active-record-queries',
  description: 'Узнайте, как воспользоваться некоторыми продвинутыми подходами к выполнению запросов, которые вы использовали в SQL и заставить Rails выполнять их автомагически.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/19_active_record_queries.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Ассоциации Active Record',
  position: lesson_position,
  slug: 'active-record-associations',
  description: 'Погрузитесь в некоторые из самых интересных возможностей ассоциаций, такие как специальные методы и полиморфизм.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/20_active_record_associations.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Ассоциации',
  position: lesson_position,
  slug: 'project-associations',
  description: 'Постройте систему управления подписками на специальные события для себя и своих друзей.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/21_project_associations.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Коллбеки Active Record',
  position: lesson_position,
  slug: 'active-record-callbacks',
  description: 'Краткий взгляд на жизненный цикл объекта Active Record с рождения до уничтожения и на то, как вы можете использовать этот процесс в своих целях.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/22_active_record_callbacks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Продвинутые ассоциации',
  position: lesson_position,
  slug: 'project-advanced-associations',
  description: 'Поупражняйтесь в создании ассоциаций, чтобы закончить руководство как профи.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/23_project_advanced_associations.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Продвинутые формы',
  position: lesson_position,
  slug: 'advanced-forms',
  description: 'Расширьте свои познания о формах. Не бойтесь создавать формы для чего угодно.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/24_advanced_forms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Создаем продвинутые формы',
  position: lesson_position,
  slug: 'project-building-advanced-forms',
  description: 'Создайте систему покупки авиабилетов, включающую интересные и сложные решения.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/25_project_forms_advanced.md'
  )

# = Шестой раздел = #

section_position += 1
section = create_or_update_section(
  title: 'API, мейлеры и продвинутые темы',
  position: section_position,
  slug: 'apis-mailers-and-advanced-topics',
  description: 'Этот финальный раздел посвятит вас в некоторые из наиболее интересных сторон экосистемы Rails, которые помогут вам продвинуть ваши приложения еще дальше и научить их отправлять почту своим пользователям или использовать возможности других приложений через их API.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Чужие API и создание своего собственного',
  position: lesson_position,
  slug: 'apis-and-building-your-own',
  description: 'Rails - это на самом деле API. Узнайте об API и о том, как превратить ваше приложение в одно из них.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/26_api_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Работаем с внешними API',
  position: lesson_position,
  slug: 'working-with-external-apis',
  description: 'Получите множество новых возможностей, используя внешние API других сервисов.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/27_api_interfacing.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: API',
  position: lesson_position,
  slug: 'project-apis',
  description: 'В этом проекте вы создадите собственный API и поработаете с внешним API.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/28_project_apis.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Мейлеры',
  position: lesson_position,
  slug: 'mailers',
  description: 'Вряд ли вы часто задумываетесь, откуда получаете все эти сервисные электронные письма. Теперь вы научитесь отправлять их сами.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/29_mailers.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Отправка подтверждающих писем',
  position: lesson_position,
  slug: 'project-sending-confirmation-emails',
  description: 'Добавьте функционал отправки писем в ваш проект. Только не спамьте, это не очень одобряется.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/30_project_mailers.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Продвинутые темы',
  position: lesson_position,
  slug: 'advanced-topics',
  description: 'Обзор нескольких тем, которые мы еще не успели затронуть: продвинутые роуты, метапрограммирование и паттерны проектирования.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/31_advanced_topics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Финальный проект',
  position: lesson_position,
  slug: 'project-final-project',
  description: 'Вы должны были создать довольно популярное приложение-социальную сеть. Об этом когда-нибудь могут снять фильм.',
  is_project: true,
  section: section,
  course: course,
  url: '/rails/32_project_final.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'rails-conclusion',
  description: 'Святая корова, вы достигли конца пути!.. Ну или вроде того.',
  is_project: false,
  section: section,
  course: course,
  url: '/rails/33_conclusion.md'
  )

# = Пятый курс = #

course_position += 1
course = create_or_update_course(
  title: 'HTML5 и CSS3',
  slug: 'html5-and-css3',
  short_description: 'Теперь вы профессионал в создании бэкенда для сайта, настало время как следует вникнуть в фронтенд, чтобы ваши сайты перестали быть уродливыми и вы начали понимать DOM. Этот короткий курс даст вам инструменты для прекращения борьбы с вашим CSS и начала создания более логично выглядящих сайтов.',
  description: 'В этом курсе вы преодолеете свой страх перед CSS и начнете понимать некоторые из фундаментальных принципов хорошего дизайна сайтов. Это не полный курс по фронтенд-дизайну, но он должен дать вам инструменты, которые понадобятся для глубокого понимания CSS-фреймворков и для создания приятно выглядящего фасада к вашему гениальному бэкенду.',
  you_learn: ['Все о стилизации при помощи CSS', 'Как эффективно использовать фронтенд-фреймворк вроде Bootstrap', 'Базовые принципы разметки и дизайна сайта'],
  you_build: ['Визуальные копии нескольких популярных сайтов', 'Свой собственный фронтенд-фреймворк', 'Охапку CSS-трюков и тактик'],
  teaser: 'Более глубокое погружение и понимание того, как делать сайты по-настоящему красивыми.',
  position: course_position,
  is_active: true
  )

# = Первый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Базовая HTML-структура страницы',
  position: section_position,
  slug: 'basic-html-page-structure',
  description: 'В этом разделе мы узнаем практически все об HTML, чтобы вы не испытывали дискомфорт при редактировании и добавлении новых элементов в нужные места страницы.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как будет работать этот курс',
  position: lesson_position,
  slug: 'html-css-how-this-course-will-work',
  description: 'Давайте узнаем, с чего мы начнем и чем закончим.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/01_how-this-course-will-work.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы HTML5',
  position: lesson_position,
  slug: 'html5-basics',
  description: 'Освежим память, вспомнив самые основы HTML',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/02_html5_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Ссылки на внешние и внутренние страницы',
  position: lesson_position,
  slug: 'linking-internal-and-external-pages',
  description: 'Когда делать ссылки локальными, а когда - внешними? Как создать ссылку на локальную страницу?',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/03_linking-internal-and-external-pages.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Работаем с видео, изображениями и прочим медиа',
  position: lesson_position,
  slug: 'working-with-images-videos-and-other-media',
  description: 'Медиа-объекты делают вашу страницу более оживленной, но есть несколько нюансов, избегание которых позволит ускорить загрузку страницы.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/04_working_with_media.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Вставлем изображения и видео',
  position: lesson_position,
  slug: 'project-embedding-images-and-video',
  description: 'Чтобы попрактиковать свежеобретенные навыки, вы воспроизведете главную страницу YouTube.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/05_project_media.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Что нового в HTML5',
  position: lesson_position,
  slug: 'what-s-new-in-html5',
  description: 'Введение HTML5 в использование добавило несколько новых элементов и нюансов, которые сделают вашу жизнь легче.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/06_new_html5.md'
  )

# = Второй раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Отображение и ввод данных',
  position: section_position,
  slug: 'section-displaying-and-inputting-data',
  description: 'Отображение и ввод данных - это две самых важных обязанности веб-разработчика. Мы рассмотрим доступные инструменты, включая таблицы и списки для отображения и формы для ввода.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Таблицы в HTML',
  position: lesson_position,
  slug: 'tables-in-html',
  description: 'Таблицы теперь используются не так часто, как прежде, но они по-прежнему прекрасно подходят для отображения структурированной информации.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/07_tables.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Упорядоченные и неупорядоченные списки',
  position: lesson_position,
  slug: 'ordered-and-unordered-lists',
  description: 'Списки используются повсеместно, даже в столь неожиданных местах, как навигационные меню.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/08_lists.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Формы для получения данных',
  position: lesson_position,
  slug: 'forms-for-collecting-data',
  description: 'Формы позволяют пользователю отправлять данные в ваше приложение и представляют собою одну из самых непростых частей в HTML-структуре страницы.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/09_html_forms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: HTML-формы',
  position: lesson_position,
  slug: 'project-html-forms',
  description: 'Попрактикуйтесь, создайте несколько разных форм, воспроизводя элементы регистрации с Mint.com',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/10_project_html_forms.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'CSS3',
  position: section_position,
  slug: 'css3',
  description: 'Здесь мы рассмотрим все фундаментальные аспекты CSS гораздо глубже, чем вы, вероятно, изучали их ранее.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы CSS3',
  position: lesson_position,
  slug: 'css3-basics',
  description: 'Даже если вы знакомы с CSS, не помешает вспомнить основы.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/11_css3_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Блочная модель',
  position: lesson_position,
  slug: 'the-box-model',
  description: 'Даже опытные разработчики нередко имеют сложности с пониманием блочная модели, которая описывает то, как должны располагаться элементы страницы.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/12_the_box_model.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Выравнивание и позиционирование',
  position: lesson_position,
  slug: 'floating-and-positioning',
  description: 'Позиционирование элементов на странице позволит вам аккуратно их расположить, так что изучение того, как элементы взаимодействуют друг с другом определенно стоит вашего времени.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/13_floats_and_positioning.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Выравнивание и позиционирование элементов',
  position: lesson_position,
  slug: 'project-floating-and-positioning-of-elements',
  description: 'Длинные "куски" контента устарели и были заменены краткими блоками со вставками медиа-элементов. Попробуйте на практике то, что узнали ранее о позиционировании.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/14_project_positioning_and_floating_elements.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Лучшие практики',
  position: lesson_position,
  slug: 'html-css-best-practices',
  description: 'Одно дело - иметь набор инструментов, и совсем другое - понимать, как лучше всего использовать их. В этом уроке мы изучим некоторые из лучших практик.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/15_best_practices.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Фоны и градиенты',
  position: lesson_position,
  slug: 'backgrounds-and-gradients',
  description: 'Здесь вы узнаете о размещении и позиционировании фоновых изображений и поработаете с градиентами.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/16_backgrounds_and_gradients.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Работаем с фонами и градиентами',
  position: lesson_position,
  slug: 'project-building-with-backgrounds-and-gradients',
  description: 'Apple - лидер в оформлении продукта, и главная страница их сайта научит вас многому в работе с фонами и градиентами.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/17_building_with_backgrounds_and_gradients.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Дизайн и юзабилити',
  position: section_position,
  slug: 'design-and-ux',
  description: 'Если вы не хотите, чтобы ваши сайты выглядели приветом из 90-х, вам необходимо будет получить понимание как минимум лучших практик дизайна и юзабилити. Не знание этих вещей равносильно тому, чтобы прыгнуть в реку, не зная, не водятся ли в ней пираньи.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Введение в дизайн и юзабилити',
  position: lesson_position,
  slug: 'introduction-to-design-and-ux',
  description: 'Некоторые фундаментальные понятия дизайна, которые мы будем использовать.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/18_design_ux.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Шрифты и типографика',
  position: lesson_position,
  slug: 'fonts-and-typography',
  description: 'Понимание шрифтов и типографики - не самая близкая область для гика, но оно даст вам огромное преимущество при оформлении ваших страниц.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/19_typography.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'CSS-сетки',
  position: lesson_position,
  slug: 'css-grids',
  description: 'Контент нельзя просто взять и беззаботно швырнуть на страницу - применение сетки позволяет визуально упорядочить преподносимую информацию.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/20_css_grids.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Дизайн',
  position: lesson_position,
  slug: 'project-teardown-in-design',
  description: 'Первый шаг в понимании дизайна заключается в том, чтобы научить себя *видеть* дизайн, сделав его, вы получите шанс удостоиться одной из громких наград, таких, как признание Smashing Magazine.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/21_project_design.md'
  )

# = Четвертый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Адаптивный дизайн и CSS-фреймворки',
  position: section_position,
  slug: 'responsive-design-and-css-frameworks',
  description: 'В наши дни вы должны быть уверены, что ваш сайт одинаково хорошо выглядит на экранах с разным разрешением. Этого можно достичь, используя медиа-запросы и резиновые макеты. К счастью, существуют фреймворки, такие, как Bootstrap, которые могут сэкономить вам огромное количество времени при разработке стандартных страниц и которые предоставляют все необходимое для создания адаптивного дизайна.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Адаптивный дизайн',
  position: lesson_position,
  slug: 'responsive-design',
  description: 'Ваши сайты должны хорошо выглядеть как на экране компьютера, так и на экране планшета и смартфона, и мы здесь расскажем вам, как этого достичь.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/22_responsive_design.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Создаем адаптивный дизайн',
  position: lesson_position,
  slug: 'project-responsive-design',
  description: 'Настало время на практике применить навыки построения адаптивного дизайна.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/23_project_responsive.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'CSS-фреймворки: Bootstrap и Foundation',
  position: lesson_position,
  slug: 'css-frameworks-bootstrap-foundation',
  description: 'Теперь, когда вы освоились с основами CSS и HTML, пора значительно упростить ваш рабочий процесс, применив CSS-фреймворк',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/24_css_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Используем Bootstrap',
  position: lesson_position,
  slug: 'project-using-bootstrap',
  description: 'Попробуйте Bootstrap в деле. Поначалу работа с ним может показаться слегка странной, но все станет ЗНАЧИТЕЛЬНО проще, когда вы поймете, в чем суть.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/25_project_bootstrap.md'
  )

# = Пятый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Продвинутый CSS3',
  position: section_position,
  slug: 'advanced-css3',
  description: 'Мы продвинемся дальше основ CSS и получим представление о некоторых более продвинутых возможностях, начиная с того, как сделать ваши элементы более стильными и заканчивая инструментами вроде препроцессоров, которые позволят экономить ваше время и избегать дублирования кода.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Анимация, визуальные эффекты и совместимость',
  position: lesson_position,
  slug: 'animations-subtle-effects-and-compatibility',
  description: 'Затронем одну из самых интересных вещей, которая предоставит в ваше распоряжение анимации и переходы, доступные только в CSS3',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/26_stylings.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Использование CSS-препроцессоров для экономии времени',
  position: lesson_position,
  slug: 'using-css-preprocessors-to-save-time',
  description: 'Узнайте о препроцессорах, таких, как SASS, который заставит ваш CSS-код быть более похожим на... код. Это хорошо, потому что экономит вам время и седину в волосах.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/27_preprocessors.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Разрабатываем собственный фреймворк, основанный на сетке',
  position: lesson_position,
  slug: 'project-design-your-own-framework',
  description: 'Финальный проект потребует от вас применения почти всего, что вы изучили в этом разделе. Вы создадите собственный CSS-фреймворк! И сможете использовать его в своих последующих проектах.',
  is_project: true,
  section: section,
  course: course,
  url: '/html5_and_css3/28_project_css_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'html-css-conclusion',
  description: 'Вы видите свет в конце тоннеля.',
  is_project: false,
  section: section,
  course: course,
  url: '/html5_and_css3/29_conclusion.md'
  )

# = Шестой курс = #

course_position += 1
course = create_or_update_course(
  title: 'Javascript и jQuery',
  slug: 'javascript-and-jquery',
  short_description: 'Последний компонент в вашем арсенале веб-разработчика -- это умение научить ваш фронтенд динамически реагировать на действия пользователя. В этом курсе вы узнаете, как использовать Javascript и jQuery для взаимодействия с DOM и как делать вещи вроде выпадающих меню, параллакс-эффекта при прокрутке, одностраничных приложений и даже игр. Это свяжет все изученное ранее воедино в один прекрасный комплект.',
  description: 'Javascript прямо сейчас захватывает мир -- веб-приложения становятся все более и более завязанными на фронтенд. Хотя JS пока чаще всего используется для анимации выпадающих меню и валидации форм, он (при некоторой помощи магии jQuery) вырос в инструмент для создания полноценных фронтенд-приложений, включая одностраничные.',
  you_learn: ['Как создавать интерактивные игры при помощи HTML5 canvas', 'Как использовать весь набор jQuery-эффектов на DOM', 'Как организовать ваш JS-код в модульные части'],
  you_build: ['Javascript-фронтенд для вашего Rails-бэкенда', 'Собственный Javascript-фреймворк', 'Змейку, Ракеты и многое другое'],
  teaser: 'Заставит ваш сайт танцевать!',
  position: course_position,
  is_active: true
  )

# = Первый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Основы и браузер',
  position: section_position,
  slug: 'the-basics-and-the-browser',
  description: 'Мы пройдемся по основам Javascript и узнаем, как он используется в браузере. Вы неплохо повеселитесь, поскольку сможете увидеть результат ваших усилий прямо в браузере. К концу раздела вы будете знать все, что необходимо для создания интересного фронтенда, но мы, конечно же, только начинаем.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Как будет работать этот курс',
  position: lesson_position,
  slug: 'javascript-how-this-course-will-work',
  description: 'Мы начнем наш путь с правильной ноги.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/01_introduction.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы Javascript',
  position: lesson_position,
  slug: 'javascript-basics',
  description: 'Вернемся к самым основам, чтобы убедиться, что вы ничего не забыли.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/02_js_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Калькулятор',
  position: lesson_position,
  slug: 'project-calculator',
  description: 'На практике попробуем написание JS-кода, создав калькулятор.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/03_project_js_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Основы jQuery',
  position: lesson_position,
  slug: 'jquery-basics',
  description: 'Еще раз вернемся к основам, но в этот раз сфокусируемся на jQuery и манипулировании объектами на странице.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/04_jq_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Редактируем DOM при помощи jQuery',
  position: lesson_position,
  slug: 'manipulating-dom-with-jquery',
  description: 'Создадим одностраничное приложение для ресторана, используя только JS и jQuery.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/05_project_jq_basics.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Упорядочиваем свой код',
  position: lesson_position,
  slug: 'organizing-your-code',
  description: 'Здесь мы поговорим обо всем, что касается организации кода, начиная с лучших практик и заканчивая полезными библиотеками.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/06_organizing_code.md'
  )

# = Второй раздел = #

section_position += 1
section = create_or_update_section(
  title: 'События, эффекты и виджеты',
  position: section_position,
  slug: 'events-effects-and-widgets',
  description: 'События управляют всем, что вы делаете при помощи Javascript в браузере. Мы ознакомимся с ними поближе, узнаем, как они работают и что с их помощью можно сделать.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Работаем с событиями и эффектами',
  position: lesson_position,
  slug: 'working-with-events-and-effects',
  description: 'Узнайте, как использовать события, чтобы улучшить UX.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/07_events_effects.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: jQuery и DOM',
  position: lesson_position,
  slug: 'project-jquery-and-the-dom',
  description: 'Создайте игру "Змейка", в которую вы почти наверняка играли на своем первом мобильном телефоне.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/08_project_events_effects.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Используем jQuery UI для создания виджетов',
  position: lesson_position,
  slug: 'using-jquery-ui-to-build-widgets',
  description: 'Взгляните на jQuery UI и на то, какие виджеты вы можете создавать с его помощью.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/09_widgets.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Создаем карусель/слайдер изображений',
  position: lesson_position,
  slug: 'project-creating-image-slider-carousel',
  description: 'Попрактикуйтесь в создании виджетов, создав слайдер изображений, подобный тем, что вы видите на множестве сайтов.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/10_project_widgets.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Глубже в Javascript',
  position: section_position,
  slug: 'deeper-into-javascript',
  description: 'Вы можете сделать многое даже с простым Javascript, jQuery и пытливым умом. Но этот раздел погрузит вас глубже в то, как Javacscipt работает и даст вам инструменты для создания более продвинутой функциональности для ваших сайтов. Некоторые предыдущие проекты, возможно, несколько выходили за горизонты вашего понимания Javascript, но теперь мы это исправим.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Объекты, "Классы" и Прототипы',
  position: lesson_position,
  slug: 'objects-classes-and-prototypes',
  description: 'Узнайте, как эффективно использовать объекты Javascript и сократить ваш код, используя прототипы.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/11_objects_prototypes.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Область видимости и замыкания',
  position: lesson_position,
  slug: 'scope-and-closures',
  description: 'Область видимости может быть несколько неочевидной в Javascript, поскольку функции передаются и вызываются во множестве различных контекстов.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/12_scope_closures.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Крестики-нолики',
  position: lesson_position,
  slug: 'project-tip-tac-toe',
  description: 'Давайте воссоздадим классическую игру "Крестики-нолики" в браузере.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/13_project_scopes_closures.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Сравниваем Javascript и Ruby',
  position: lesson_position,
  slug: 'comparing-js-and-ruby',
  description: 'Короткий пример, показывающий, как можно использовать знание Ruby при работе с Javascript.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/14_comparing_to_ruby.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'По-настоящему понимаем функции в Javascript',
  position: lesson_position,
  slug: 'understanding-functions-in-js',
  description: 'Функции Javascript чрезвычайно важны, и здесь вы узнаете, почему.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/15_deep_dive_functions.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: "Сапер"',
  position: lesson_position,
  slug: 'project-minesweeper',
  description: 'Настало время написать что-то посложнее. Создадим "Сапер", единственную достойную игру, идущую в комплекте с Windows.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/16_project_functions.md'
  )

# = Третий раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Продвинутая работа браузера',
  position: section_position,
  slug: 'advanced-browser-work',
  description: 'При помощи браузера и Javascript можно делать намного больше, чем просто манипулировать DOM, используя jQuery. Если вы хотите собирать данные с сайтов или с собственного бэкенда, отправлять формы или создавать более сложные игры, вам придется понять, как Javascript работает с такими вещами, как коллбеки. Так же мы расскажем о том, как создавать игры, используя элемент `<canvas>`, появившийся в HTML5. Здесь Javascript пригодится нам для рисования фигур.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Загружаем Javascript в браузер',
  position: lesson_position,
  slug: 'loading-js-in-the-browser',
  description: 'Кратко о том, как и когда загружать Javascript.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/17_js_to_browser.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Коллбеки: жизнь в мире, управляемом событиями',
  position: lesson_position,
  slug: 'callbacks-living-in-events-driven-world',
  description: 'Этот урок свяжет в единое целое ваше знание о событиях со стандартным паттерном для взаимодействия с этими событиями.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/18_event_driven.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Коллбеки',
  position: lesson_position,
  slug: 'project-callbacks',
  description: 'Возможность применить полученные знания о коллбеках, создав еще одно браузерное приложение.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/19_project_callbacks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Используем канвас для рисования и не только',
  position: lesson_position,
  slug: 'using-canvas-for-drawing-and-more',
  description: 'Когда вы поймете принцип работы canvas, вы будете ограничены лишь собственным воображением (и, возможно, своими навыками в геометрии).',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/20_canvas.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Создаем игры при помощи Canvas',
  position: lesson_position,
  slug: 'project-building-games-with-canvas',
  description: 'Посмотрим, насколько весело будет создавать при помощи canvas, воссоздадим классическую игру Missile Command!',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/21_project_canvas.md'
  )

# = Четвертый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Улучшаем формы, используя jQuery и AJAX',
  position: section_position,
  slug: 'better-forms-using-jquery-and-ajax',
  description: 'В этом разделе вы изучите AJAX, технологию, которая позволяет отправлять данные из браузера в ваше веб-приложение без необходимости перезагружать страницу. AJAX очень часто используется с формами, но помимо них представляет целый мир возможностей для создания приятного UX.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Валидируем формы при помощи jQuery',
  position: lesson_position,
  slug: 'validating-forms-using-jquery',
  description: 'Теперь вы эксперт в формах, но здесь мы сфокусируемся на использовании jQuery при работе с ними.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/22_jquery_forms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Валидируем формы при помощи jQuery',
  position: lesson_position,
  slug: 'project-validating-forms-with-jquery',
  description: 'Возможность использовать плагин jQuery Validate, а затем создать собственную валидацию для форм.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/23_project_forms.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Отправляем форму без перезагрузки, используя AJAX',
  position: lesson_position,
  slug: 'submitting-form-with-ajax',
  description: 'AJAX - недостающее звено между бесшовным клиентским UX и вашим серверным кодом.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/24_ajax.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Бесконечная прокрутка и отправка форм при помощи AJAX',
  position: lesson_position,
  slug: 'project-infinite-scroll-and-submitting-forms-with-ajax',
  description: 'Мы поиграем с AJAX, используя его для запросов к открытому API OMDB и создадим простую форму и страницу со списком фильмов, которая будет использовать бесконечную прокрутку.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/25_project_ajax_forms.md'
  )

# = Пятый раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Соединяем фронтенд с API и вашим бэкендом на Rails',
  position: section_position,
  slug: 'linking-to-apis-andyour-rails-backend',
  description: 'Полноценное веб-приложение нуждается в бэкенде, чтобы соханять свои данные и выполнять необходимые операции. Здесь вы узнаете, как использовать AJAX для отправки данных и запросов к вашему бэкенду на Rails. Так же вы сможете поработать со внешними API, такими как Google Maps, что вы, вероятнее всего, будете делать довольно часто, работая над своими будущими проектами.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Работаем с API при помощи Javascript',
  position: lesson_position,
  slug: 'working-with-javascript-apis',
  description: 'Работа с удаленными API с клиентской части вашего приложения может быть отличным способом добавления динамической функциональности к вашим сайтам.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/26_javascript_apis.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Вставляем Google Maps на ваш сайт',
  position: lesson_position,
  slug: 'project-putting-google-maps-on-your-site',
  description: 'Практически каждый бизнес должен иметь на своем сайте страничку с контактными данными и картой, указывающей адрес компании на ней. Сделайте это при помощи Google Maps API.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/27_project_apis.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Используем Ruby on Rails в качестве бэкенда',
  position: lesson_position,
  slug: 'using-ruby-on-rails-for-your-backend',
  description: 'Вы уже поработали с внешними API, настало время использовать ваш бэкенд на Ruby on Rails в этом качестве.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/28_rails_backend.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Где Уолли',
  position: lesson_position,
  slug: 'project-where-is-waldo',
  description: 'Используйте все, что вы изучили, чтобы создать игру "Где Уолли".',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/29_project_rails_backend.md'
  )

# = Шестой раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Серверный Javascript и Javascript-фреймворки',
  position: section_position,
  slug: 'server-side-js-and-js-frameworks',
  description: 'Это НЕОБЯЗАТЕЛЬНЫЙ раздел, где вы узнаете об использовании Javascript на вашем сервере (вместо Ruby) и о фреймворках на Javascript, которые позволят вам создать полноценный сайт в виде single-page application, используя Javascript для молниеносно быстрого UX.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Node.js и серверный Javascript',
  position: lesson_position,
  slug: 'node-js-and-server-side-js',
  description: 'В наши дни можно не расставаться с любимым Javascript, потому что теперь его можно писать и для серверной стороны, используя Node.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/30_server_side_js.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Node.js',
  position: lesson_position,
  slug: 'project-node-js',
  description: 'Запустите сервер на Node и поиграйтесь с ним, потому что только так мы и учимся новому.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/31_project_node.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Используем шаблоны',
  position: lesson_position,
  slug: 'using-templates',
  description: 'Шаблонизаторы предоставляют волшебную возможность использовать макеты на клиентской стороне снова и снова.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/32_templating.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Javascript MV* фреймворки, такие как Angular.js и Backbone.js',
  position: lesson_position,
  slug: 'using-templates',
  description: 'Фронтенд-фреймворки помогут вам организовать мешанину из AJAX-вызовов, шаблонов и jQuery-кода и позволят вам невероятно ускорить создание превосходного фронтенда.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/33_js_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Javascript MV* фреймворки, такие как Angular.js и Backbone.js',
  position: lesson_position,
  slug: 'js-frameworks-angularjs-backbonejs',
  description: 'Фронтенд-фреймворки помогут вам организовать мешанину из AJAX-вызовов, шаблонов и jQuery-кода и позволят вам невероятно ускорить создание превосходного фронтенда.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/33_js_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Проект: Создаем SPA при помощи Angular.js и Backbone.js',
  position: lesson_position,
  slug: 'project-build-spa-with-angularjs-backbonejs',
  description: 'Выберите фреймворки и опробуйте его на этих туториалах.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/34_project_js_frameworks.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Рабочие инструменты, набор технологий и управление зависимостями',
  position: lesson_position,
  slug: 'workflow-tools-tech-stack-dependency-management',
  description: 'Несколько инструментов, которые облегчат вам работу.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/35_workflow_tools.md'
  )

# = Седьмой раздел = #

section_position += 1
section = create_or_update_section(
  title: 'Заканчиваем с Javascript',
  position: section_position,
  slug: 'finishing-up-with-javascript',
  description: 'Вы изучили все, что вам необходимо, и осталось лишь применить ваши знания в достойной задаче. В этом разделе мы кратко расскажем о том, как тестировать Javascript при помощи Jasmine и затем предложим вам выполнить завершающий проект, в котором вы сможете продемонстрировать все полученные знания.',
  course: course
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Тестирование Javascript с Jasmine',
  position: lesson_position,
  slug: 'testing-javascript-with-jasmine',
  description: '...потому что если вы это не протестируете, вы не узнаете, что оно сломалось, когда это произойдет.',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/36_js_testing.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Финальный проект',
  position: lesson_position,
  slug: 'js-final-project',
  description: 'Соберите все, что вы узнали, изучая этот курс, и примените это в проекте, где вы создадите ваш любимый сайт с нуля.',
  is_project: true,
  section: section,
  course: course,
  url: '/javascript/37_project_final_js.md'
  )

lesson_position += 1
create_or_update_lesson(
  title: 'Заключение',
  position: lesson_position,
  slug: 'js-conclusion',
  description: 'Что-ж, это было несложно, верно?',
  is_project: false,
  section: section,
  course: course,
  url: '/javascript/38_conclusion.md'
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
