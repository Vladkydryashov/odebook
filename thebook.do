## -*- coding: utf-8 -*-

<%
import sys
sys.path.insert(0, '.')
# Allow imports from local dir to import nesode and odebook

import matplotlib
matplotlib.use('Agg')
# Need this to plot pictures without graphical backend

import nesode as no
from odebook import needfigure, savefigs,mkfig
import odebook as book 
%>

<%def name="begin_question()">
## sphinx doesn't allow quizes inside questions
% if FORMAT == 'sphinx':
__Контрольный вопрос.__ 
% else:
!bquestion Контрольный вопрос
%endif
</%def>

<%def name="end_question()">
% if FORMAT != 'sphinx':
!equestion
%endif
</%def>

TITLE: Элементарное введение в дифференциальные уравнения
AUTHOR: И. В. Щуров, НИУ ВШЭ
AUTHOR: Основано на конспекте лекций курса «Дифференциальные уравнения» (2013-14 учебный год, СБ ВШЭ-РЭШ)
AUTHOR: Авторы курса: И. А. Хованская и И. В. Щуров
AUTHOR: В подготовке конспектов принимал участие Андрей Петрин
DATE: today

!split
======= Понятие дифференциального уравнения =======

===== Примеры моделей, приводящих к дифференциальным уравнениям =====
Прежде, чем говорить о дифференциальных уравнения в общем виде, обсудим
несколько простых примеров, в которых они возникают естественным образом.

=== Рост населения. Мальтузианская модель ===

Пусть скорость роста популяции какого-нибудь вида (например, рыб в пруду или бактерий в чашке Петри) в любой момент времени пропорциональна количеству особей в популяции в этот момент времени. Это предположение кажется разумным (какая-то часть популяции за единицу времени воспроизводится), если есть достаточное количество ресурсов. Обозначим размер популяции в момент времени $t$ через $x(t)$. Тогда мгновенная скорость роста равна $\frac{dx(t)}{dt}$. Обычно производная по переменной $t$ обозначается точкой $\dot x(t)$, а не штрихом. Таким образом, наш закон роста размера популяции можно записать так:
!bt
\begin{equation}
\dot x(t)=kx(t),
\end{equation}
!et
где $k>0$ — коэффициент пропорциональности (константа).

Зависимость от $t$ обычно опускают, и пишут просто
!bt
\begin{equation}
\dot x=kx.
\end{equation}
!et
Это — одно из простейших (и важнейших) дифференциальных уравнений. Неизвестной величиной в ней является не число (как в обычных алгебраических уравнениях) и не вектор (как в линейной алгебре), а функция $x(t)$.

=== Рост экономики. Модель Солоу ===

Согласно модели Солоу, скорость прироста капитоловооруженности экономики (количества капитала в расчёте на одного трудоспособного человека) в предположении отсутствия внешней торговли, технического прогресса и роста населения, описывается формулой
!bt
\[
\dot k=sf(k)-\delta k,
\]
!et
где $k=k(t)$ — капиталовооруженность экономики в момент времени $t$, $s$ — норма сбережения, $\delta$ — норма выбытия капитала.

=== Механическая система. Падающий шарик ===

Если я возьму в руку маленький тяжелый шарик, что с ним произойдёт, когда я его отпущу? Не нужно проводить этот эксперимент на практике и даже решать дифференциальное уравение, чтобы ответить: он станет падать вниз с ускорением. Это подскажет нам наша физическая интуиция. Использование интуиции и ранее накопленного опыта очень важно при решении задач, поэтому мы время от времени будем обращаться к механическим примерам.

Пусть вертикальная координата шарика (высота) в момент времени $t$ есть $y(t)$. Известно, что на тело, находящееся в поле тяготения земли (на не слишком большой высоте) действует сила тяжести, равная
!bt
\[
F=-mg,
\]
!et
где $m$ — масса тела, $g$ — ускорение свободного падения (примерно равно 
%if FORMAT == 'pdflatex':
10~м/с\textsuperscript{2}),
%else:
10~м/с<sup>2</sup>),
%endif
знак «-» выбран, поскольку сила тяжести действует в направлении «вниз» (против направления роста $y$).

С другой стороны, второй закон Ньютона гласит, что *ускорение* тела пропорционально действующей на него силе и обратно пропорционально массе:
!bt
\[
    a=F/m\quad\Leftrightarrow\quad F=ma.
\]
!et
Ускорение — это вторая производная от координаты по времени, она обозначается двумя точками. Таким образом, мы имеем дифференциальное уравнение, описывающее движение шарика:
!bt
\[
    \ddot y=-g.
\]
!et

===== Простейшие дифференциальные уравнения =====

Вернёмся к математической точке зрения на дифференциальные уравнения. Начнём с
относительно общего определения.

=== Дифференциальное уравнение общего вида ===

Дифференциальным уравнением называется соотношение вида
!bt
\begin{equation}
    label{eq:general}
    \dot x=f(t, x),
\end{equation}
!et
где $x=x(t)$ — неизвестная функция, $f(t, x)$ — известная функция двух переменных. Мы пока что будем рассматривать уравнения, в которых областью значений неизвестной функции являются вещественные числа $\mathbb R$, но чуть позже обсудим и более сложные случаи, когда $x$ принимает значение в многомерных пространствах.

*Решением* дифференциального уравнения называется дифференцируемая функция $x=\varphi(t)$, такая, что при подстановке её в уравнение получается верное равенство:
!bt
\begin{equation}
\dot \varphi(t)=f(t, \varphi(t))\quad \forall t\in D(f),
\end{equation}
!et
где $D(f)$ — область определения функции $f$: это может быть вся числовая ось, луч, отрезок, интервал или полуинтервал.

__Замечание.__ Мы будем предполагать, что областью определения решения
дифференциального уравнения является связное множество (то есть, например,
объединение двух непересекающихся отрезков запрещено): всё-таки
дифференциальные уравнения пришли из реальных физических задач и описывают
модель реального процесса — трудно представить себе, что функция, описывающая состояние
некоторой системы, была бы сначала определена, потом не определена, а потом снова
определена. 

Рассмотрим несколько примеров.

=== Нулевая правая часть ===

Простейшее дифференциальное уравнение, которое только можно придумать, имеет вид
!bt
\[
\dot x=0.
\]
!et
Его решениями являются функции $x(t)=C$, где $C$ — любая константа. Действительно, если функция имеет нулевую производную и при этом всюду дифференцируема, то она не меняется и значит равна константе. Заметим, что даже в таком простейшем случае мы имеем не одно, а сразу целое семейство решений. Аналогичная ситуация будет и в более сложных примерах.

=== Постоянная правая часть ===

Чуть более сложное уравнение:
!bt
\[
\dot x=k,
\]
!et
где $k$ — константа. Это уравнение движения с постоянной скоростью, его решениями являются всевозможные линейные функции
!bt
\[
x(t)=kt+C,
\]
!et

Заметим, что в этом случае констант $C$ задаёт значение функции в начальный момент времени $t=0$.

=== Правая часть, зависящая только от времени ===

Рассмотрим несколько более сложный пример: пусть функция $f(t,x)$ в правой части
(ref{eq:general}) на самом деле не зависит от $x$.

!bt
\begin{equation}
label{eq:int}
\dot x=f(t).
\end{equation}
!et
Задачу отыскания решения такого дифференциального уравнения можно сформулировать следующим образом: *для каждого значения независимой переменной $t$ известна проиводная некоторой функции; найти эту функцию*. Нетрудно видеть, что это в точности задача интегрирования (отыскания первообразной). Решение такого уравнения задаётся таким образом *неопределенным интегралом*, который можно записать в виде
!bt
\begin{equation}
label{eq:intsol}
x(t)=\int f(t) dt=\int_{t_0}^t f(\tau)d\tau+C.
\end{equation}
!et

Неопределенный интеграл по определению является семейством функций, а при записи его в виде определенного интеграла с переменным верхним пределом нужно указывать константу интегрирования явным образом.

=== Начальные условия. Задача Коши ===

idx{Задача Коши}

Чтобы выделить среди семейства решений дифференциального уравнения одно, обычно вместе с самим дифференциальным уравнением рассматривают дополнительное соотношение, называемое *начальным условием* — значение решение в какой-то момент времени (не обязательно $t=0$). 

Когда задано дифференциальное уравнение и начальное условие, говорят, что поставлена *задача Коши*.

Например, можно рассмотреть такую задачу:

!bt
\begin{equation}
label{eq:Cauchy}
\dot x=f(t),\quad x(5)=0
\end{equation}
!et

Eё решением будет уже только одна функция:
!bt
\begin{equation}
label{eq:Cauchy_sol}
x(t)=\int_5^t f(\tau)d\tau
\end{equation}
!et
Действительно, любой интеграл вида (ref{eq:intsol}) является решением уравнения (ref{eq:int}), а значит и функция в (ref{eq:Cauchy_sol}) им является. Остаётся проверить начальное условие. При подстановке $t=5$ решение $x(5)=\int_5^5 f(\tau)d\tau = 0$, то есть начальное условие выполняется.

${begin_question()}
Каким будет решение уравнения (ref{eq:int}) при начальном условии $x(5)=1$?
!bquiz
Q: [] Выберите верный вариант:

Cw: [] $x(t)=\int_5^1 f(\tau)d\tau$

E: Неверно, эта функция вообще является константой.

Cr: [] $x(t)=\int_5^t f(\sigma)d\sigma + 1$

E: Верно!

Cw: [] $x(t)=\int_t^t f(\tau)d\tau + 1$

E: Неверно, обратите внимание на пределы интегрирования.
!equiz
${end_question()}

=== Простейшее линейное уравнение ===

Положим в уравнении роста населения $k=1$. Получим следующее уравнение:
!bt
\begin{equation}
\dot x=x
label{eq:xdotx}
\end{equation}
!et
Какие функции будут его решениями? Словами можно сказать, что условие, накладываемое этим уравнением, звучит так: «Производная функции равна самой этой функции». Одна известная функция обладает таким свойством — это экспонента $x(t)=e^t$. Нетрудно видеть, что если умножить экспоненту на любое число, получающаяся функция $x(t)=Ce^t$ также будет решением этого уравнения. В частности, очевидно, что решением будет функция $x(t)\equiv 0$.

${begin_question()}
Является ли решением уравнения (ref{eq:xdotx}) функция $x(t)=e^t+C$ при $C\ne 0$?
!bquiz
Q: [] Выберите верный вариант:

Cw: [] Да, при любых $C\ne 0$.

E: Это неверно, попробуйте подставить функцию в уравнение и посчитать
производную.

Cw: [] При некоторых $C\ne 0$ является, а при других нет.

E: Это неверно, попробуйте подставить функцию в уравнение и посчитать
производную.

Cr: [] Не является ни при каких $C\ne 0$.

E: Верно, если подставить функцию в уравнение, $C$ уничтожится при
дифференцировании в левой части, но не уничтожится в правой. Таким образом,
уравнение (ref{eq:xdotx}) принципиально отличается от уравнений вида
(ref{eq:int}), рассмотренных ранее.
!equiz
${end_question()}

__Замечание.__ Мы пока не доказали, что других решений, кроме перечисленных, у этого уравнения нет. Мы вернемся к этому вопросу через одну лекцию. 

=== Геометрические объекты ===

В рассмотренных выше примерах неизвстная функция $x(t)$ принимала значения во множестве вещественных чисел. В общем случае функция $x(t)$ может принимать значения в других множествах — например, в многомерных пространствах. Множество, в котором принимает значение неизвестная функция (или, иными словами, множество всевозможных значений $x(t)$ при каком-нибудь фиксированном $t$) называется *фазовым пространством* дифференциального уравнения. Множество точек вида $(t, x)$ (декартово произведение фазового пространсва на ось времени) называется *расширенным фазовым пространством*. График решения называется *интегральной кривой*. Интегральные кривые живут в расширенном фазовом пространстве.

Построим некоторые интегральные кривые для уравнения $\dot x=x$. Как мы уже знаем, ими будут графики экспонент.


<%
no.rcParams['figure.figsize']=(8,6)

if needfigure("l01exp"):
    no.axes4x4()
    initials = range(-5, -1) + [0.15] + [x/no.exp(1) for x in 1, 2, 3]
    initials.extend([-x for x in initials])
    initials.append(0)
    for C in initials:
        no.mplot(no.linspace(-4,4),lambda t: C*no.exp(t),color='blue',
                 linewidth=1.5) 
    savefigs()
%>

${mkfig(u"Графики решений дифференцильного уравнения $\dot x=x$")}

Если бы мы не знали, какие на самом деле решения нашего дифференциального уравнения (а это наиболее распространенный случай, чаще всего дифференциальные уравнения не решаются явно), мы всё равно могли бы примерно представить себе, как выглядят интегральные кривые. Чтобы это сделать, нам нужно построить *поле направлений* или *поле прямых*.

Вот что это такое. Возьмём произвольную точку $P=(t_0, x_0)$ расширенного фазового пространства. Например, $t_0=1$, $x_0=3$. Мы можем провести в точке $P$ касательную к интегральной кривой, проходящей через эту точку. Действительно, чтобы провести прямую через фиксированную точку, нужно знать только её угловой коэффициент, но угловой коэффициент касательной к графику некоторой функции равняется производной этой функции. А производную решения мы знаем, по определению решения она равна правой части уравнения. Для уравнения (ref{eq:xdotx}) правая часть в точке $x$ равна $x$ и значит касательная, проходящая через точку $P$, имеет угловой коэффициент, равный $x_0=3$. Можно взять ещё несколько точек на прямой $t=1$ и провести соответствующие касательные через них. Получится такая картинка, см. рис. ref{fig:l01dirfield1}.

<%
if needfigure("l01dirfield1"):
    no.axes4x4()
    xs=range(-4,5)
    no.scatter([1]*len(xs),xs)
    for x0 in xs:
        no.mplot(no.linspace(0,5),lambda t: x0*(t-1)+x0,linestyle='dashed',linewidth=0.5,color='black')
        no.mplot(no.linspace(1-0.2,1+0.2),lambda t: x0*(t-1)+x0,color='red',linewidth=1.5)
    savefigs()
%>

${mkfig(u"Касательные к решениям")}

${begin_question()}
Почему прямые пересекаются в начале координат?
${end_question()}

Понятно, что можно, действуя аналогично, построить касательные к решениям не только в выбранных точках, но и вообще в любой точке расширенного фазового пространства. В данном случае правая часть не зависит от $t$ явно, поэтому через любые две точки, лежащие на одной горизонтальной прямой, будут проходить параллельные касательные. Мы будем рисовать только маленькие кусочки этих касательных. 


<%
if needfigure("l01dirfield2"):
    no.cla()
    no.axes4x4()
    no.normdirfield(no.arange(-4,4,0.5),no.arange(-4,4,0.5),lambda x,y: y,color='red',linewidth=1.5,length=0.6)
    savefigs()
%>

${mkfig(u"Поле направлений")}

На картинке изображены прямые, проходящие через какие-то конкретные точки, но на самом деле такая прямая может быть проведена через любую точку. Вся совокупность этих прямых и будет *полем направлений*. 

__Замечание.__ Часто в этом месте возникает вопрос: прямые, проходящие через
каждую точку плоскости, заполнят собой всю плоскость — значит ли это, что поле
направлений является всей плоскостью? На самом деле, нет: поле направлений не
является *объединением* прямых; прямые, проведённые через разные точки, никак не
взаимодействуют друг с другом. Более аккуратно было бы сказать, что поле
направлений — это отображение из расширенного фазового пространства во множество
прямых, проходящих через фиксированную точку. Чтобы это сказать совсем
аккуратно, следовало бы ввести понятие касательного расслоения, но мы этого не
делать не будем.

<%
if needfigure("l01dirfield3"):
    no.cla()
    no.axes4x4()
    no.normdirfield(no.arange(-4,4,0.5), no.arange(-4,4,0.5),lambda x,y: y,color='red',linewidth=1.5,length=0.6)
    for C in initials:
        no.mplot(no.linspace(-4,4),lambda t: C*no.exp(t),color='blue', linewidth=1.5) 
    savefigs()
%>

${mkfig(u"Поле направлений и интегральные кривые")}

Теперь задача отыскания решения дифференциального уравнения сводится к такой геометрической задаче: нужно найти кривую, которая в каждой своей точке касается прямой, принадлежащей полю направлений и проходящей через эту точку.

Эта интерпретация скоро окажется для нас очень полезной.

!split

======= Автономные дифференциальные уравнения на прямой =======

*Продолжение следует, не переключайтесь!...*

