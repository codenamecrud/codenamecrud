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
  title: 'Проект: строительные блоки',
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
  title: 'Проект: продвинутые строительные блоки',
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
  teaser: 'Скоро будет доступно!',
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
  title: 'Проект: первые шаги',
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
  title: 'Проект: аутентификация',
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
  title: 'Проект: Продвинутые ассоациации',
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
