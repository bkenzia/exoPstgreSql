--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select num_potion, lib_potion, formule, constituant_principal from potion ;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
SELECT nom_categ ,nb_points
FROM categorie c where c.nb_points ='3' ;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select nom_village  from village v   where nb_huttes >35 ;


--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select num_trophee ,date_prise  from trophee t where date_prise between '2052-05-01' AND '2052-06-30'  ;


--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select nom  from habitant h where nom like 'A%r%';


--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
SELECT distinct  h.num_hab  from habitant h
                                     join absorber a on a.num_hab =h.num_hab
where a.num_potion in(1,3,4);


--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select t.num_trophee ,t.date_prise, c.nom_categ ,t.num_preneur
from trophee as t
         join categorie as c on t.code_cat  = c.code_cat ;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select nom from habitant as h join village as v on h.num_village =v.num_village where v.nom_village ='Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select nom
from habitant as h
         join trophee as t on h.num_hab = t.num_preneur
         join categorie as c on t.code_cat =c.code_cat where c.nom_categ ='Bouclier de Légat';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select p.lib_potion ,p.formule , p.constituant_principal  from potion as p
                                                                   join fabriquer as f on p.num_potion =f.num_potion
                                                                   join habitant as h  on f.num_hab =h.num_hab
where h.nom ='Panoramix';


--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select distinct  p.lib_potion from potion p
                                       join absorber as a  on p.num_potion =a.num_potion
                                       join habitant as h  on a.num_hab =h.num_hab
where h.nom ='Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct  h.nom  from  potion p
                                  join fabriquer f   on p.num_potion=f.num_potion
                                  join absorber a on a.num_potion =p.num_potion
                                  join habitant h on a.num_hab =h.num_hab
where f.num_hab =3;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct  h.nom  from  potion p
                                  join fabriquer f   on p.num_potion=f.num_potion
                                  join absorber a on a.num_potion =p.num_potion
                                  join habitant h on a.num_hab =h.num_hab
where f.num_hab = (select num_hab from habitant  where nom='Amnésix');

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select nom, num_qualite  from habitant h where num_qualite isnull ;


--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select nom, a.date_a  from habitant h
                               join absorber a on h.num_hab =a.num_hab
where (
    a.num_potion = (select p.num_potion  from potion p  where p.lib_potion ='Potion magique n°1')
        and a.date_a between '2052-01-01' AND '2052-02-29');

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select nom , age from habitant h ORDER BY nom asc ;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select  num_resserre , v.nom_village  from resserre r
                                               join village v on v.num_village =r.num_village ;

--18. Nombre d'habitants du village numéro 5. (4)
select  count(*)from habitant h  where h.num_village =5;


--19. Nombre de points gagnés par Goudurix. (5)
SELECT SUM(c.nb_points) from categorie c
                                 join trophee t on t.code_cat =c.code_cat
where t.num_preneur = (select h.num_hab  from habitant h where h.nom ='Goudurix' );


--20. Date de première prise de trophée. (03/04/52)
select  date_prise  from trophee t  where num_trophee =1;


--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum(a.quantite) from absorber a
                                join potion p     on a.num_potion =p.num_potion
where(p.lib_potion ='Potion magique n°2');


--22. Superficie la plus grande. (895)
SELECT MAX (superficie) FROM resserre r ;


--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select v.nom_village,COUNT(h.num_hab)  from village v
                                                join habitant h on v.num_village =h.num_village
group by v.nom_village ;


--24. Nombre de trophées par habitant (6 lignes)
select count(t.num_trophee), h.nom  from trophee t
                                             join habitant h on h.num_hab =t.num_preneur
group by (h.num_hab);


--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select avg(age)  , p.nom_province  from habitant h
                                            join village v on v.num_village =h.num_village
                                            join province p on v.num_province =p.num_province
group by p.num_province ;



--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select  h.nom  , count(a.num_potion)  from habitant h
                                               join absorber a on a.num_hab =h.num_hab
group by h.nom
HAVING COUNT(a.num_potion)>2;


--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

select v.num_village  from village v
                               join resserre r on v.num_village =r.num_village ;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select  v.nom_village   from village v
where v.nb_huttes =(SELECT max(v2.nb_huttes)FROM village v2);

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
select h.nom, count(t.num_trophee)  from habitant h
                                             join trophee t on t.num_preneur  =h.num_hab
group by h.nom
HAVING COUNT(t.num_trophee)>1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
select h.nom, count(t.num_trophee)  from habitant h
                                             join trophee t on t.num_preneur  =h.num_hab
group by h.nom
HAVING COUNT(t.num_trophee)>(select count(t.num_trophee)  from habitant h
                                                                   join trophee t on t.num_preneur  = h.num_hab
                             where h.nom ='Obélix'
                             group by h.nom);