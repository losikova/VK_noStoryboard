# VK

1. Создать приложение.

2. Добавить форму для входа.

3. Адаптировать форму для телефонов в альбомной ориентации, планшетов.

________________________________________________________________________________

1. Добавить в приложение UITabbarViewController, три UITableViewController и один UICollectionViewController.

2. После того, как пользователь ввел верные логин и пароль, перейти на UITabbarViewController.

3. Добавить две вкладки в UITabbarViewController.

4. На первой вкладке настроить переходы в следующем порядке: UINavigationController — UITableViewController — UICollectionViewController. Будущая вкладка для отображения друзей пользователя ВКонтакте и его фотографий. Переход с таблицы на коллекцию должен происходить по нажатию на ячейку.

5. На второй вкладке — в порядке: UINavigationController — UITableViewController — UITableViewController. Первый контроллер для отображения групп пользователя, второй для отображения глобального поиска групп, которые могут быть интересны пользователю. Для перехода с первой таблицы на вторую на NavigationBar необходимо создать Bar Button Item.

________________________________________________________________________________

1. Добавить на все контроллеры прототипы ячеек.

2. На первой вкладке UITableViewController должен отображать список друзей пользователя. В прототипе ячеек должна быть текстовая надпись с именем друга и изображением с его аватаркой.

3. UICollectionViewController должен отображать фото выбранного друга, соответственно, в прототипе ячейки должно быть изображение.

4. На второй вкладке UITableViewController должен отображать группы пользователя. Прототип должен содержать текстовую надпись для имени группы и изображение для её аватарки.

5. Второй UITableViewController будет отображать группы, в которых пользователь не состоит. В будущем мы добавим возможностью поиска сообщества по названию. Ячейки должны использоваться такие же, как и на прошлом контроллере.

6. Создать папку Model. В ней создать файлы содержащие struct, или class, описывающий профиль пользователя — User, группу ВКонтакте — Group.

7. Подготовить массивы демонстрационных данных, отобразить эти данные на соответствующих им экранах.

8. Реализовать добавление и удаление групп пользователя.

________________________________________________________________________________

1. Создать свой View для аватарки. Он должен состоять из двух subview:

1) Должен содержать UIImageView с фотографией пользователя и быть круглой формы.

2) Должен находиться ниже и давать тень по периметру фотографии. Учтите, что тень будет отображена, если backgroudColor != .clear.

2. Предусмотреть возможность изменения ширины, цвета, прозрачности тени в interface builder. (задание на самостоятельный поиск решения).

3. Создать контрол «Мне нравится», с помощью которого можно поставить лайк под постом в ленте. Данный контрол должен объединять кнопку с иконкой сердца и количеством отметок рядом с ней. При нажатии на контрол нужно увеличить количество отметок, а при повторном нажатии — уменьшить (как это реализовано в приложении ВКонтакте). В состоянии, когда отметка поставлена, иконка и текст должны менять цвет.

4. (*) Сделать контрол, позволяющий выбрать букву алфавита. Он понадобится на экране списка друзей. Дизайн можно позаимствовать у оригинального приложения ВКонтакте. Должна быть возможность выбрать букву нажатием или перемещением пальца по контролу. При выборе нужно пролистывать список к первому человеку, у которого фамилия начинается на эту букву. Желательно сделать так, чтобы в этом контроле не было букв, на которые не начинается ни одна фамилия друзей из списка. (необязательное, для тех, у кого есть время)

________________________________________________________________________________

1. Сделать группировку друзей по первой букве фамилии. Добавить header секции для таблицы со списком друзей. Он должен содержать первую букву фамилии и иметь полупрозрачный цвет фона, цвет которого совпадает с цветом таблицы.

2. Добавьте UISearchBar в header таблицы со списком групп. Укажите контроллер, содержащий эту таблицу, делегатом UISearchBar, реализуйте поиск с выводом результатов в ту же таблицу. Для простоты реализации не стоит использовать UISearchController (задание на самостоятельный поиск решения).

3. Создать экран новостей. Добавить туда таблицу и сделать ячейку для новости. Ячейка должна содержать то же самое, что и в оригинальном приложении ВКонтакте: надпись, фотографии, кнопки «Мне нравится», «Комментировать», «Поделиться» и индикатор количества просмотров. Сделать поддержку только одной фотографии, которая должна быть квадратной формы и растягиваться на всю ширину ячейки. Высота ячейки должна вычисляться автоматически.

4. (*) В ячейку новости добавить отображение нескольких фотографий. Они должны располагаться в квадратной зоне, ширина которой равна ширине ячейки. В идеале нужно сделать равномерное расположение фотографий в квадратной области (необязательное, для тех, у кого есть время).

________________________________________________________________________________

1. Создать индикатор загрузки, который будет состоять из трех точек, меняющих прозрачность по очереди.

2. Добавить анимацию нажатия на аватарку пользователя/группы в соответствующих таблицах. По нажатию фотография должна немного сжиматься, а после — возвращаться в исходное положение с эффектом пружины. Нужно подобрать оптимальное время анимации, чтобы получить максимально реалистичный эффект.

3. Сделать анимацию изменения количества отметок «Мне нравится». Это может быть любая анимация: переворот из стороны в сторону, плавная смена или перелистывание.

4. (*) Сделать кастомную строку поиска (как UISearchBar). Посередине должна находиться иконка лупы. Когда строку поиска активируют, лупа перемещается в сторону и останавливается с эффектом пружины. Также в этот момент строка поиска сужается с правой стороны и на пустом месте появляется кнопка отмены. Все это происходит анимировано. Когда поиск отменяется или со строки поиска снимается фокус, она должна вернуться в исходное состояние (необязательное, для тех, у кого есть время).

________________________________________________________________________________

1. На экране просмотра фото добавить возможность просматривать все снимки по очереди. На весь экран, как и раньше, будет фотография, но перелистывать можно будет свайпами.

2. Сделать анимацию перелистывания, которая состоит из двух частей. Сначала фотография немного отдаляется, а затем новый снимок выдвигается справа. При пролистывании назад анимация должна показываться в обратном направлении.

3. (*) Модифицировать анимацию перелистывания фотографий так, чтобы она была интерактивной — с возможностью начать перелистывать и отменить это действие, а также управлять прогрессом анимации.

4. (*) Модифицировать индикатор загрузки. Удалить предыдущую анимацию и сделать новую — фигуру в виде облака, по контуру которого передвигается линия. Линия должна быть фиксированной длины, с закругленными концами.

________________________________________________________________________________

1. Сделать анимацию переходов между экранами в UINavigationController. Появляющийся экран сначала находится за пределами видимости и повернут на 90 градусов, при этом его верхний правый угол прижат к такому же углу текущего экрана. В момент перехода появляющийся экран разворачивается относительно верхнего правого угла и становится на место текущего. Анимация закрытия должна выглядеть точно наоборот.

2. Сделать интерактивную анимацию закрытия экрана в UINavigationController. В качестве распознавателя жестов использовать UIScreenEdgePanGestureRecognizer.

3. (*) Сделать анимацию показа и закрытия экрана просмотра фотографии. При нажатии картинка увеличивается на весь экран, а при закрытии — уменьшается до исходного размера.

4. (*) Добавить возможность закрыть экран просмотра фотографии с помощью жеста смахивания вниз.

________________________________________________________________________________

1. Добавить CoreData в таб новостей(добавление новой группы, удаление)

2. Сделать отображение новостей через запрос(пример: https://jsonplaceholder.typicode.com, https://jsonplaceholder.typicode.com/posts). Перед запросом показать лоудер, как только запрос выполниться убрать лоудер и отобразить новости.(Можете поставить дефолтную картинку, а описание новостей брать через запрос )

________________________________________________________________________________

1. Добавить в проект синглтон для хранения данных о текущей сессии – Session.

2. Добавить в него свойства:

token: String – для хранения токена в VK,
userId: Int – для хранения идентификатора пользователя ВК.

________________________________________________________________________________
