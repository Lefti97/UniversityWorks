close all;
clear all;
clc;

t = readtable('18390008_VACCINATION_DATA.xlsx');
tItaly      = t(t.iso_code=="ITA",1:51);
tPortugal   = t(t.iso_code=="PRT",1:51);
tCanada     = t(t.iso_code=="CAN",1:51);

clear t

figure('units','normalized','outerposition',[0 0 0.5 0.5])

% ITALY PLOTS

plot(tItaly.date, tItaly.new_cases_per_million)
title('Italy - New cases per million')
exportgraphics(gcf,'imgs/plot_new_cases_per_million_ITA.png')

plot(tItaly.date, tItaly.new_deaths_per_million)
title('Italy - New deaths per million')
exportgraphics(gcf,'imgs/plot_new_deaths_per_million_ITA.png')

plot(tItaly.date, tItaly.reproduction_rate)
title('Italy - Reproduction rate')
exportgraphics(gcf,'imgs/plot_reproduction_rate_ITA.png')

plot(tItaly.date, tItaly.icu_patients_per_million)
title('Italy - ICU patients per million')
exportgraphics(gcf,'imgs/plot_icu_patients_per_million_ITA.png')

plot(tItaly.date, tItaly.hosp_patients_per_million)
title('Italy - Hospital patients per million')
exportgraphics(gcf,'imgs/plot_hosp_patients_per_million_ITA.png')

plot(tItaly.date, tItaly.new_tests_per_thousand)
title('Italy - New tests per thousand')
exportgraphics(gcf,'imgs/plot_new_tests_per_thousand_ITA.png')

plot(tItaly.date, tItaly.positive_rate)
title('Italy - Positive rate')
exportgraphics(gcf,'imgs/plot_positive_rate_ITA.png')

plot(tItaly.date, tItaly.total_vaccinations_per_hundred)
title('Italy - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/plot_total_vaccinations_per_hundred_ITA.png')

plot(tItaly.date, tItaly.people_vaccinated_per_hundred)
title('Italy - People vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_vaccinated_per_hundred_ITA.png')

plot(tItaly.date, tItaly.people_fully_vaccinated_per_hundred)
title('Italy - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_fully_vaccinated_per_hundred_ITA.png')

plot(tItaly.date, tItaly.total_boosters_per_hundred)
title('Italy - Total boosters per hundred')
exportgraphics(gcf,'imgs/plot_total_boosters_per_hundred_ITA.png')


% PORTUGAL PLOTS

plot(tPortugal.date, tPortugal.new_cases_per_million)
title('Portugal - New cases per million')
exportgraphics(gcf,'imgs/plot_new_cases_per_million_PRT.png')

plot(tPortugal.date, tPortugal.new_deaths_per_million)
title('Portugal - New deaths per million')
exportgraphics(gcf,'imgs/plot_new_deaths_per_million_PRT.png')

plot(tPortugal.date, tPortugal.reproduction_rate)
title('Portugal - Reproductions rate')
exportgraphics(gcf,'imgs/plot_reproduction_rate_PRT.png')

plot(tPortugal.date, tPortugal.icu_patients_per_million)
title('Portugal - ICU patients per million')
exportgraphics(gcf,'imgs/plot_icu_patients_per_million_PRT.png')

plot(tPortugal.date, tPortugal.hosp_patients_per_million)
title('Portugal - Hospital patients per million')
exportgraphics(gcf,'imgs/plot_hosp_patients_per_million_PRT.png')

plot(tPortugal.date, tPortugal.new_tests_per_thousand)
title('Portugal - New tests per thousand')
exportgraphics(gcf,'imgs/plot_new_tests_per_thousand_PRT.png')

plot(tPortugal.date, tPortugal.positive_rate)
title('Portugal - Positive rate')
exportgraphics(gcf,'imgs/plot_positive_rate_PRT.png')

plot(tPortugal.date, tPortugal.total_vaccinations_per_hundred)
title('Portugal - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/plot_total_vaccinations_per_hundred_PRT.png')

plot(tPortugal.date, tPortugal.people_vaccinated_per_hundred)
title('Portugal - People vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_vaccinated_per_hundred_PRT.png')

plot(tPortugal.date, tPortugal.people_fully_vaccinated_per_hundred)
title('Portugal - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_fully_vaccinated_per_hundred_PRT.png')

plot(tPortugal.date, tPortugal.total_boosters_per_hundred)
title('Portugal - Total boosters per hundred')
exportgraphics(gcf,'imgs/plot_total_boosters_per_hundred_PRT.png')


% CANADA PLOTS

plot(tCanada.date, tCanada.new_cases_per_million)
title('Canada - New cases per million')
exportgraphics(gcf,'imgs/plot_new_cases_per_million_CAN.png')

plot(tCanada.date, tCanada.new_deaths_per_million)
title('Canada - New deaths per million')
exportgraphics(gcf,'imgs/plot_new_deaths_per_million_CAN.png')

plot(tCanada.date, tCanada.reproduction_rate)
title('Canada - Reproduction rate')
exportgraphics(gcf,'imgs/plot_reproduction_rate_CAN.png')

plot(tCanada.date, tCanada.icu_patients_per_million)
title('Canada - ICU patients per million')
exportgraphics(gcf,'imgs/plot_icu_patients_per_million_CAN.png')

plot(tCanada.date, tCanada.hosp_patients_per_million)
title('Canada - Hospital patients per million')
exportgraphics(gcf,'imgs/plot_hosp_patients_per_million_CAN.png')

plot(tCanada.date, tCanada.new_tests_per_thousand)
title('Canada - New tests per thousand')
exportgraphics(gcf,'imgs/plot_new_tests_per_thousand_CAN.png')

plot(tCanada.date, tCanada.positive_rate)
title('Canada - Positive rate')
exportgraphics(gcf,'imgs/plot_positive_rate_CAN.png')

plot(tCanada.date, tCanada.total_vaccinations_per_hundred)
title('Canada - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/plot_total_vaccinations_per_hundred_CAN.png')

plot(tCanada.date, tCanada.people_vaccinated_per_hundred)
title('Canada - People vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_vaccinated_per_hundred_CAN.png')

plot(tCanada.date, tCanada.people_fully_vaccinated_per_hundred)
title('Canada - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/plot_people_fully_vaccinated_per_hundred_CAN.png')

plot(tCanada.date, tCanada.total_boosters_per_hundred)
title('Canada - Total boosters per hundred')
exportgraphics(gcf,'imgs/plot_total_boosters_per_hundred_CAN.png')



% ITALY BOXPLOTS

g = [
        repmat({'FEB-APR 20'},  length(2:91), 1);
        repmat({'MAY-JUL 20'},        length(92:183), 1);
        repmat({'AUG-OCT 20'},  length(184:275), 1);
        repmat({'NOV-JAN 21'},length(276:367), 1);
        repmat({'FEB-APR 21'},  length(368:456), 1);
        repmat({'MAY-JUL 21'},        length(457:548), 1);
        repmat({'AUG-OCT 21'},  length(549:634), 1);
    ];

arr = tItaly.new_cases_per_million;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - New cases per million')
exportgraphics(gcf,'imgs/boxplot_new_cases_per_million_ITA.png')

arr = tItaly.new_deaths_per_million;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - New deaths per million')
exportgraphics(gcf,'imgs/boxplot_new_deaths_per_million_ITA.png')

arr = tItaly.reproduction_rate;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - Reproduction rate')
exportgraphics(gcf,'imgs/boxplot_reproduction_rate_ITA.png')

arr = tItaly.icu_patients_per_million;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - ICU patients per million')
exportgraphics(gcf,'imgs/boxplot_icu_patients_per_million_ITA.png')

arr = tItaly.hosp_patients_per_million;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - Hospital patients per million')
exportgraphics(gcf,'imgs/boxplot_hosp_patients_per_million_ITA.png')

arr = tItaly.new_tests_per_thousand;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - New tests per thousand')
exportgraphics(gcf,'imgs/boxplot_new_tests_per_thousand_ITA.png')

arr = tItaly.positive_rate;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - Positive rate')
exportgraphics(gcf,'imgs/boxplot_positive_rate_ITA.png')

arr = tItaly.total_vaccinations_per_hundred;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/boxplot_total_vaccinations_per_hundred_ITA.png')

arr = tItaly.people_vaccinated_per_hundred;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - People vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_vaccinated_per_hundred_ITA.png')

arr = tItaly.people_fully_vaccinated_per_hundred;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_fully_vaccinated_per_hundred_ITA.png')

arr = tItaly.total_boosters_per_hundred;
x = [arr(2:91);arr(92:183);arr(184:275);arr(276:367);arr(368:456);arr(457:548);arr(549:634);];
boxplot(x, g)
title('Italy - Total boosters per hundred')
exportgraphics(gcf,'imgs/boxplot_total_boosters_per_hundred_ITA.png')



% PORTUGAL BOXPLOTS

g = [
        repmat({'FEB-APR 20'},  length(4:72), 1);
        repmat({'MAY-JUL 20'},        length(73:164), 1);
        repmat({'AUG-OCT 20'},  length(165:256), 1);
        repmat({'NOV-JAN 21'},length(257:348), 1);
        repmat({'FEB-APR 21'},  length(349:437), 1);
        repmat({'MAY-JUL 21'},        length(438:529), 1);
        repmat({'AUG-OCT 21'},  length(530:615), 1);
    ];

arr = tPortugal.new_cases_per_million;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - New cases per million')
exportgraphics(gcf,'imgs/boxplot_new_cases_per_million_PRT.png')

arr = tPortugal.new_deaths_per_million;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - New deaths per million')
exportgraphics(gcf,'imgs/boxplot_new_deaths_per_million_PRT.png')

arr = tPortugal.reproduction_rate;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - Reproduction rate')
exportgraphics(gcf,'imgs/boxplot_reproduction_rate_PRT.png')

arr = tPortugal.icu_patients_per_million;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - ICU patients per million')
exportgraphics(gcf,'imgs/boxplot_icu_patients_per_million_PRT.png')

arr = tPortugal.hosp_patients_per_million;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - Hospital patients per million')
exportgraphics(gcf,'imgs/boxplot_hosp_patients_per_million_PRT.png')

arr = tPortugal.new_tests_per_thousand;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - New tests per thousand')
exportgraphics(gcf,'imgs/boxplot_new_tests_per_thousand_PRT.png')

arr = tPortugal.positive_rate;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - Positive rate')
exportgraphics(gcf,'imgs/boxplot_positive_rate_PRT.png')

arr = tPortugal.total_vaccinations_per_hundred;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/boxplot_total_vaccinations_per_hundred_PRT.png')

arr = tPortugal.people_vaccinated_per_hundred;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - People vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_vaccinated_per_hundred_PRT.png')

arr = tPortugal.people_fully_vaccinated_per_hundred;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_fully_vaccinated_per_hundred_PRT.png')

arr = tPortugal.total_boosters_per_hundred;
x = [arr(4:72);arr(73:164);arr(165:256);arr(257:348);arr(349:437);arr(438:529);arr(530:615);];
boxplot(x, g)
title('Portugal - Total boosters per hundred')
exportgraphics(gcf,'imgs/boxplot_total_boosters_per_hundred_PRT.png')


% CANADA BOXPLOTS

g = [
        repmat({'FEB-APR 20'},  length(7:96), 1);
        repmat({'MAY-JUL 20'},        length(97:188), 1);
        repmat({'AUG-OCT 20'},  length(189:280), 1);
        repmat({'NOV-JAN 21'},length(281:372), 1);
        repmat({'FEB-APR 21'},  length(373:461), 1);
        repmat({'MAY-JUL 21'},        length(462:553), 1);
        repmat({'AUG-OCT 21'},  length(554:639), 1);
    ];

arr = tCanada.new_cases_per_million;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - New cases per million')
exportgraphics(gcf,'imgs/boxplot_new_cases_per_million_CAN.png')

arr = tCanada.new_deaths_per_million;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - New deaths per million')
exportgraphics(gcf,'imgs/boxplot_new_deaths_per_million_CAN.png')

arr = tCanada.reproduction_rate;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - Reproduction rate')
exportgraphics(gcf,'imgs/boxplot_reproduction_rate_CAN.png')

arr = tCanada.icu_patients_per_million;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - ICU patients per million')
exportgraphics(gcf,'imgs/boxplot_icu_patients_per_million_CAN.png')

arr = tCanada.hosp_patients_per_million;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - Hospital patients per million')
exportgraphics(gcf,'imgs/boxplot_hosp_patients_per_million_CAN.png')

arr = tCanada.new_tests_per_thousand;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - New tests per thousand')
exportgraphics(gcf,'imgs/boxplot_new_tests_per_thousand_CAN.png')

arr = tCanada.positive_rate;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - Positive rate')
exportgraphics(gcf,'imgs/boxplot_positive_rate_CAN.png')

arr = tCanada.total_vaccinations_per_hundred;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - Total vaccinations per hundred')
exportgraphics(gcf,'imgs/boxplot_total_vaccinations_per_hundred_CAN.png')

arr = tCanada.people_vaccinated_per_hundred;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - People vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_vaccinated_per_hundred_CAN.png')

arr = tCanada.people_fully_vaccinated_per_hundred;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - People fully vaccinated per hundred')
exportgraphics(gcf,'imgs/boxplot_people_fully_vaccinated_per_hundred_CAN.png')

arr = tCanada.total_boosters_per_hundred;
x = [arr(7:96);arr(97:188);arr(189:280);arr(281:372);arr(373:461);arr(462:553);arr(554:639);];
boxplot(x, g)
title('Canada - Total boosters per hundred')
exportgraphics(gcf,'imgs/boxplot_total_boosters_per_hundred_CAN.png')
