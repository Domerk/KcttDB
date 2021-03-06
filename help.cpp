#include "help.h"
#include "ui_help.h"

Help::Help(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Help)
{
    ui->setupUi(this);
    ui->splitter->setSizes(QList <int> () << 120 << 400);
    ui->treeWidget->setColumnHidden(1, true);
    this->setWindowTitle(tr("Справка"));
    this->setWindowFlags(Qt::Window | Qt::WindowSystemMenuHint | Qt::WindowMinMaxButtonsHint | Qt::WindowCloseButtonHint);

    ui->textEdit->setHtml("<h2>Добро пожаловать в UdoDB!</h2>"
                          "<p>UdoDB - приложение для работы с базами данных учреждения дополнительного образования. "
                          "Оно позволяет легко и быстро находить, просматривать, изменять, добавлять и удалять данные об учащихся, преподавателях, группах и объединениях.</p>"
                          "<p>Ознакомьтесь с данным руководством, чтобы получить представление о возможностях приложения. А если что-то останется непонятным, загляните в расширенную версию руководства UdoHelp.pdf или на <a href=https://github.com/Domerk/UdoDB/wiki>домашнюю страницу</a> проекта.</p>");
}

// ============================================================

Help::~Help()
{
    delete ui;
}

// ============================================================

void Help::on_treeWidget_itemClicked(QTreeWidgetItem *item, int column)
{
    int index = item->text(1).toInt();
    ui->textEdit->clear();
    switch (index)
    {
    case 0: {
        ui->textEdit->setHtml("<h2>Установка и первоначальная настройка системы</h2>"
                              "<p>Приложения UdoDB и FormUdod являются клиентами для работы с базами данных. Создание самих баз данных и входящих в их состав элементов осуществляется через выполнение SQL-скрипта. Текстовый файл расположен в каталоге Other каждого приложения. "
                              "Удаление баз данных, так же, как их создание, не может осуществляться через интерфейс приложений-клиентов.</p>"
                              "<p>Для осуществления контроля доступа к приложениям рекомендуется применять политики безопасности в соответствии с потребностями конкретного учреждения. Приложение-анкету FormUdod рекомендуется запускать на терминалах.</p>"
                              "<p>Для осуществления работы с базами данных через клиентские приложения, последним нужно указать необходимые параметры соединения. Если соединение установлено верно, то в нижней части экрана приложения появится строка «Соединение установлено». "
                              "Иначе будет выведена строка, сообщающая об ошибке.</p>");
        break;
    }
    case 1: {
        ui->textEdit->setHtml("<h2>Работа с конфигурационными файлами</h2>"
                              "<p>Настройка обоих клиентских приложений, входящих в состав системы (UdoDB и FormUdod), осуществляется с использованием технологии QSettings через изменение конфигурационных файлов. "
                              "Конфигурационные файлы config.ini каждого приложения располагаются в каталоге Other и могут быть открыты и изменены в любом текстовом редакторе.</p>"
                              "<p>В конфигурационных файлах в виде пар &laquo;Ключ = Значение&raquo; прописываются данные, необходимые для установления соединения с базой (хост, имя базы, имя пользователя и пароль), "
                              "а также некоторые иные параметры (заголовок главного окна приложения, название организации и др.), изменяя которые, администратор системы получает возможность персонализировать её и приспособить для нужд конкретного УДО.</p>"
                              "<p>Изменения, внесённые в конфигурационный файл приложения, вступают в силу только после его перезагрузки. Если конфигурационный файл по каким-либо причинам отсутствует или повреждён, к приложению будут применены настройки по умолчанию.</p>");
        break;
    }
    case 2: {
        ui->textEdit->setHtml("<h2>Настройка UdoDB через пользовательский интерфейс</h2>"
                              "<p>Для UdoDB предусмотрена возможность изменения настроек соединения с базами данных через пользовательский интерфейс. Чтобы открыть окно настроек, следует выбрать пункт меню <b>Файл &rarr; Соединение</b>. "
                              "В открывшемся окне можно просмотреть текущие параметры соединения с обеими базами и внести необходимые изменения. Для того, чтобы эти изменения вступили в силу, нужно нажать кнопку &laquo;Применить&raquo;, "
                              "после чего приложение запросит подтверждение совершаемого действия, предупредив пользователя о возможных последствиях.</p>");
        break;
    }
    case 3: {
        ui->textEdit->setHtml("<h2>Запись в объединения</h2>"
                              "<p>Запись в объединения осуществляется родителями (или иными законными представителями) учащихся через специальное приложение-анкету FormUdod. Интерфейс данного приложения состоит из главного окна с заполняемыми пользователем полями и "
                              "вспомогательных окон справки и поддержки, вызываемых через нажатие соответствующих значков на панели инструментов главного окна.</p>"
                              "<p>При работе с данным приложением пользователю доступны следующие действия:</p><ul>"
                              "<li>Отправить данные;</li>"
                              "<li>Очистить форму;</li>"
                              "<li>Вызвать окно помощи;</li>"
                              "<li>Вызвать окно справки.</li></ul>"
                              "<p>В целях безопасности приложение-анкета FormUdod спроектировано таким образом, что просмотр занесённых в базу сведений, их изменение и удаление, а также изменение настроек самого приложения через его интерфейс полностью невозможны.</p>"
                              "<p>При попытке пользователя сохранить введённые данные происходит автоматическая проверка на заполнение обязательных полей. Если одно или несколько таких полей не заполнено, появляется сообщение с соответствующим текстом, "
                              "а отправки данных и очистки формы не происходит. То есть, прочитав предупреждение, пользователь может вернуться к заполнению формы и попытаться сохранить данные ещё раз.</p>"
                              "<p>Если форма заполнена верно, появится окно, запрашивающее подтверждение совершаемого действия.</p>");
        break;
    }
    case 4: {
        ui->textEdit->setHtml("<h2>Просмотр таблиц</h2>"
                              "<p>Основными элементами главного окна приложения UdoDB являются дерево, с помощью которого осуществляется навигация по базе, таблица, форма для добавления и изменения записей, панель инструментов, панель простого поиска и меню. "
                              "Кроме того, в нижней части экрана расположена строка состояния, в которую выводится краткая информация о состоянии системы.</p>"
                              "<p>Если соединение с базой данных настроено верно, то в нижней части окна приложения должна появиться соответствующая надпись. При этом в таблицу будут выведены все имеющиеся в базе записи об учащихся, а в дерево добавлен блок, "
                              "позволяющий просматривать списки групп по объединениям и направленностям.</p>"
                              "<p>Если соединение по каким-либо причинам отсутствует, в строку состояния будет выведено соответствующее сообщение, а таблица останется пустой.</p>"
                              "<p>Для выбора таблицы, которую следует вывести на экран, используется дерево навигации. Оно включает в себя два блока: «Общее» и «Направленности». В блоке «Общее» отображены названия основных сущностей, для работы с которыми предназначена система. "
                              "В блок «Направленности» выводятся названия всех имеющихся в базе направленностей, а также, в иерархическом виде, названия входящих в их состав объединений, вложенными элементами для которых являются группы.</p>"
                              "<p>При выборе элемента из дерева автоматически формируется запрос к БД и в таблицу выводятся записи, относящиеся к выбранному элементу.</p>"
                              "<p>Вывод в форму подробной информации осуществляется автоматически, при выделении в таблице ячейки или целой строки.</p>");
        break;
    }
    case 5: {
        ui->textEdit->setHtml("<h2>Настройка внешнего вида</h2>"
                              "<p>В приложении предусмотрена возможность настройки отображения таблиц. Выбрав в меню пункт <b>Таблица &rarr; Скрыть / Показать поля</b> или выбрав соответствующий элемент на панели инструментов, "
                              "пользователь может в открывшемся окне отметить галочками названия тех полей, которые должны быть отображены. Остальные поля будут автоматически скрыты, но содержащиеся в них данные останутся доступными для просмотра через форму, "
                              "расположенную в правой части главного окна. Вывод в форму подробной информации осуществляется автоматически, при выделении в таблице ячейки или целой строки.</p>");
        break;
    }
    case 6: {
        ui->textEdit->setHtml("<h2>Работа с данными</h2>"
                              "<p>При работе с данными через приложение UdoDB пользователю доступны следующие действия:</p><ul>"
                              "<li>Добавление данных через форму;</li>"
                              "<li>Импорт данных из временной базы;</li>"
                              "<li>Изменение записей;</li>"
                              "<li>Удаление записей.</li></ul>");
        break;
    }
    case 7: {
        ui->textEdit->setHtml("<h2>Добавление данных через форму</h2>"
                              "<p>Добавление записей в базу осуществляется через форму, расположенную в правой части главного окна приложения. Перед началом её заполнения следует убедиться, что она пуста. "
                              "Для того, чтобы очистить её, необходимо выбрать пункт меню <b>Строка &rarr; Новая запись</b>, выбрать соответствующий элемент на панели инструментов или выделить пустую строку, находящуюся в конце таблицы.</p>"
                              "<p>После этого можно перейти к заполнению полей формы. Поля, являющиеся обязательными, отмечены символом *. Кроме того, во избежание ввода пользователем некорректных данных, "
                              "для ряда полей предусмотрена возможность выбора одного из предложенных валидных значений.</p>"
                              "<p>Так, например, невозможно создать группу, относящуюся к несуществующему объединению или назначить ей несуществующего преподавателя, так как для заполнения этих полей пользователю предлагается выбрать одно из значений, уже существующих в базе.</p>"
                              "<p>Для сохранения записи необходимо нажать кнопку «Сохранить» в нижней части формы. Если форма заполнена верно, приложение сформирует и отправит запрос INSERT, а сама форма будет очищена. "
                              "В противном случае будет выведено окно, сообщающее пользователю о том, что он не заполнил одно или несколько обязательных полей либо ввёл некорректные данные.</p>"
                              "<p>Сразу после сохранения, запись будет отображена в соответствующей таблице и станет доступной для изменения и удаления.</p>");
        break;
    }
    case 8: {
        ui->textEdit->setHtml("<h2>Импорт данных из временной базы</h2>"
                              "<p>Вторым способом добавления записей в базу является импорт данных, полученных при помощи приложения-анкеты. Он осуществляется путём выбора необходимых записей в таблице, "
                              "открывающейся при выборе пункта меню <b>Строка &rarr; Импортировать</b> или соответствующего элемента на панели инструментов.</p>"
                              "<p>Выбрав одну или несколько записей, пользователь может перенести их в основную базу или удалить, нажав на соответствующую кнопку. В обоих случаях запись о выбранном учащемся будет удалена из базы с данными самозаписи, "
                              "но в случае переноса данные из неё будут продублированы в основную базу.</p>"
                              "<p>Поскольку при подаче заявлений родители (или иные законные представители) указывают названия объединений, в которых хотели бы заниматься их дети, а уже на основе этих данных формируются списки групп, "
                              "то учащиеся, информация о которых была импортирована, автоматически попадают в служебные группы «Без группы», связанные с соответствующими объединениями.</p>"
                              "<p>Группа «Без группы» создаётся для каждого объединения автоматически при его создании.</p>"
                              "<p>Здесь стоит отметить, что, в случае, если учащийся был записан в объединение, которое отсутствует в основной базе, то при импорте эта информация будет потеряна. "
                              "Однако, всегда остаётся возможность установления связи между учащимся и объединением вручную, путём добавления этого учащегося в группу, входящую в состав объединения.</p>");
        break;
    }
    case 9: {
        ui->textEdit->setHtml("<h2>Изменение записей</h2>"
                              "<p>В целях защиты от непреднамеренного (случайного) изменения данных пользователем в процессе работы с приложением, данное действие может выполняться только через редактирование формы, расположенной в правой части главного окна.</p>"
                              "<p>Независимо от того, какие из полей текущей таблицы являются скрытыми, при выборе ячейки или строки в форму автоматически заносятся все данные соответствующей записи. "
                              "Пользователь может просмотреть их, изменить и сохранить изменения, нажав на кнопку «Сохранить» в нижней части формы.</p>"
                              "<p>В целом, операция редактирования существующей записи похожа на операцию создания новой, за исключением того, что в данном случае базе данных будет отправлен запрос на изменение UPDATE.</p>");
        break;
    }
    case 10: {
        ui->textEdit->setHtml("<h2>Удаление записей</h2>"
                              "<p>Удаление записей через программу-журнал возможно как для основной, так и для вспомогательной базы.</p>"
                              "<p>Чтобы удалить запись из основной базы, пользователю необходимо найти её в одной из таблиц, выделить ячейку строки или строку целиком и нажать соответствующий элемент на панели управления или выбрать пункт меню <b>Строка &rarr; Удалить текущую</b>. "
                              "Если удаление данной строки из данной таблицы (представления) возможно, соответствующий элемент управления будет активен. При его нажатии приложение запросит у пользователя подтверждение его действий, после чего выполнится запрос к базе данных.</p>"
                              "<p>Если удаление невозможно, то при выделении строки элементы, отвечающие за удаление, остаются неактивными. Кроме того, если в процессе работы приложения произошёл сбой и удаление не может быть осуществлено, на экран выведется окно с сообщением об ошибке.</p>"
                              "<p>Чтобы удалить запись из второй базы, необходимо открыть окно просмотра, выбрав на панели инструментов значок импорта или пункт меню <b>Строка &rarr; Импортировать</b>. В открывшемся окне необходимо выбрать нужную запись и нажать на кнопку «Удалить».</p>"
                              "<p>В обоих случаях удаление осуществляется путём отправки базе данных автоматически сгенерированного запроса DELETE, который либо выполняется, либо, если обращение происходит не к таблице, а к представлению, приводит в действие соответствующий триггер, "
                              "отвечающий за удаление данных.</p>");
        break;
    }
    case 11: {
        ui->textEdit->setHtml("<h2>Поиск</h2>"
                              "<p>В приложении UdoDB реализовано два способа поиска по базе: простой поиск по текущей таблице и параметризируемый поиск по всем таблицам базы.</p>");
        break;
    }
    case 12: {
        ui->textEdit->setHtml("<h2>Простой поиск</h2>"
                              "<p>Простой поиск осуществляется по одному выбранному пользователем полю текущей таблицы и доступен для всех существующих в системе таблиц и представлений. "
                              "В его основе лежит использование оператора LIKE языка запросов SQL, что позволяет осуществлять поиск не только по целым словам, но и по частям слов.</p>"
                              "<p>Для того, чтобы воспользоваться простым поискам, пользователю необходимо выбрать одно из доступных полей из выпадающего списка, ввести искомое слово и нажать кнопку поиска либо клавишу Enter. "
                              "Здесь важно отметить, что в целях безопасности функция поиска становится активна только после изменения содержимого поисковой строки: возможность повторной отправки одного и того же запроса вследствие ошибочных действий пользователя полностью исключена.</p>");
        break;
    }
    case 13: {
        ui->textEdit->setHtml("<h2>Расширенный поиск через конструктор запросов</h2>"
                              "<p>Расширенный (параметризируемый) поиск реализуется на основе конструктора запросов и позволяет пользователю формировать сложные запросы сразу к нескольким таблицам базы. "
                              "В окне конструктора пользователь может выбрать нужные ему таблицы и отметить названия полей, которые должны быть отображены в итоговой таблице, и, при необходимости, указать значения, являющиеся критериями поиска. Если ни одно поле не выбрано, то будут выведены все поля, имеющиеся в выбранных таблицах.</p>"
                              "<p>Поиск по текстовым полям реализован через оператор LIKE, а для поиска значений в данном интервале используются операторы сравнения.</p>");
        break;
    }
    case 14: {
        ui->textEdit->setHtml("<h2>Дополнительные функции</h2>"
                              "<p>К дополнительным функциям, реализованным в рамках приложения-журнала UdoDB, относятся функции экспорта. В приложении доступен экспорт таблиц в два формата: MS Excel и HTML.</p>"
                              "<p>Для того, чтобы экспортировать текущую таблицу в файл в формате .xls или .xlsx, необходимо выбрать пункт меню <b>Файл &rarr; Экспорт в Excel</b> и в открывшемся окне указать имя нового файлся или выбрать существующий файл (если он не пустой, то в процессе экспорта будет перезаписан).</p>"
                              "<p>Экспорт в формат .html осуществляется через выбор пункта меню <b>Файл &rarr; Экспорт в Html</b>. При этом пользователь можно как создать новый файл, так и выбрать существующий, который будет перезаписан.</p>");
        break;
    }
    }
}
