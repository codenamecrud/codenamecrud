# Lesson.create(
#   title: '',
#   slug: '',
#   description: '',
#   is_project: false,
#   section: Section.find_by(slug: '')
#   )

user = User.new(
    name: 'Frey',
    email: "frey@list.ru",
    password: "00000000",
    password_confirmation: "00000000"
)
user.save!


Course.destroy_all
Section.destroy_all
Lesson.destroy_all

# == Первый курс == #

Course.create(
  title: 'Введение в веб-разработку',
  slug: 'introduction-to-web-development',
  short_description: 'Этот короткий курс начнет обучение с нуля, ответит на стандартные задаваемые вопросы о практике и карьере в сфере веб-разработки. Вы получите намного лучшее представление о том, во что вы готовитесь погрузиться!',
  description: 'Этот короткий курс ответит на стандартные вопросы о практике и карьере в сфере веб-разработки. Поэтому, давайте будем честны, даже если вы явно ощущаете, что создание вещей и путь веб-разработчика словно созданы для вас, вы, вероятно, всё еще не особо представляете, чем на самом деле занимаются разработчики... и это то, с чего начинают все, так что всё в порядке.',
  you_learn: ['Что на самом деле делают веб-разработчики', 'Рабочие инструменты', 'Как найти работу веб-разработчиком'],
  you_build: ['Не спешите, скоро вы приступите к практике!'],
  teaser: 'Начните отсюда!',
  is_active: true
  )

Section.create(
  title: 'О веб-разработчиках',
  slug: 'about-web-developers',
  description: 'Начните с начала и узнайте, чем на самом деле занимаются веб-разработчики и на что похожа сфера веб-разработки.',
  course: Course.find_by(slug: 'introduction-to-web-development')
  )

Lesson.create(
  title: 'Чем занимается веб-разработчик',
  slug: 'what-a-web-developer-does',
  description: 'От того, чем на самом деле занимается разработчик к ключевым различиям вроде разделения на бэк-енд и фронт-енд, веб-разработчиков против веб-дизайнеров и веб-сайтов против веб-приложений',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers'),
  course: Course.find_by(slug: 'introduction-to-web-development'),
  url: '/introduction_to_web_development/what_does_a_web_dev_do.md'
  )

Lesson.create(
  title: 'Работа и карьера в веб-разработке',
  slug: 'web-development-jobs-and-careers',
  description: 'Несколько кратких примеров ролей веб-разработчиков в различных организациях',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers'),
  course: Course.find_by(slug: 'introduction-to-web-development'),
  url: '/introduction_to_web_development/web_dev_jobs.md'
  )

Lesson.create(
  title: 'Рабочие инструменты',
  slug: 'tools-of-trade',
  description: 'Обзор различных инструментов, испольуемых веб-разработчиками для выполнения своей работы',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers'),
  course: Course.find_by(slug: 'introduction-to-web-development'),
  url: '/introduction_to_web_development/tools_of_trade.md'
  )

Lesson.create(
  title: 'Сообщества веб-разработчиков',
  slug: 'web-development-communities',
  description: 'Разработчики - на удивление социальная группа, и здесь вы узнаете, как найти их онлайн и лично',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers'),
  course: Course.find_by(slug: 'introduction-to-web-development'),
  url: '/introduction_to_web_development/web_dev_communities.md'
  )

Lesson.create(
  title: 'Лучшие веб-разработчики',
  slug: 'the-best-web-developers',
  description: 'Несколько советов о том, что делает веб-разрабочтика великим',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers')
  )


Lesson.create(
  title: 'Ищем работу в качестве веб-разработчика',
  slug: 'getting-hired-as-a-web-developer',
  description: 'Кратко проясняем, что на самом деле хотят получить работодатели от веб-разработчика и как может выглядеть процесс найма',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers')
  )


Lesson.create(
  title: 'Заключение',
  slug: 'conclusion',
  description: 'Общий взгляд на предстоящее путешествие вниз по кроличьей норе',
  is_project: false,
  section: Section.find_by(slug: 'about-web-developers')
  )

# == Второй курс == #

Course.create(
  title: 'Основы веб-разработки',
  slug: 'basics-of-web-development',
  short_description: 'Этот курс для всех, кто начинает с нуля или не совсем комфортно чувствует себя при работе с командной строкой, HTML, CSS, Javascript, Ruby, веб-фреймворками, Git или другими базовыми технологиями веб-разработки. Мы покроем МНОЖЕСТВО тем -- к концу этого объемного курса вы будете готовы к изучению наших более углубленных курсов или продолжать исследования самостоятельно.',
  description: 'Теперь вы знаете, чем занимаются веб-разработчики, настало время подумать о том, как они этим занимаются. В этом курсе вы изучете базовые концепции веб-программирования. К его завершению вы будете способны собрать простую веб-страницу, стилизовать её, добавить интерактивные элементы и чувствовать себя комфортно при работе с командной строкой. Вы попрактикуетесь в написании простых скриптов на Ruby и Javascript, а так же познакомитесь с такими вещами, как Git и базы данных. Вы получите множество новых знаний и будете готовы "замарать руки" в практическом применении этих знаний во всех темах, которые мы будем изучать в последующих углубленных курсах.',
  you_learn: ['Как на самом деле работает Веб', 'Основы HTML, CSS и Javascript', 'Основы Ruby, Rails, Git и баз данных'],
  you_build: ['Главная страница Google на HTML/CSS', 'Динамический блокнот на JS/jQuery', 'Серия испытаний на Ruby по принципу "Тесты вперед"'],
  teaser: 'Здоровая порция всего необходимого',
  is_active: true
  )

Section.create(
  title: 'Основы',
  slug: 'the-basics',
  description: 'Этот раздел покроет базовые знания, которые вам необходимо иметь, прежде чем окунуться в более "программные" аспекты веб-разработки. Так же вы научитесь устанавливать необходимое программное обеспечение на ваш компьютер.',
  course: Course.find_by(slug: 'basics-of-web-development')
  )
