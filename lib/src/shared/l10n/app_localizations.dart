import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('pt'),
    Locale('pt', 'BR')
  ];

  /// No description provided for @text_splash_screen_page.
  ///
  /// In en_US, this message translates to:
  /// **'Jiu-jitsu for everyone'**
  String get text_splash_screen_page;

  /// No description provided for @title_appbar_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'Jiu-jitsu for everyone'**
  String get title_appbar_home_page;

  /// No description provided for @button_history_of_jiujitsu_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'History'**
  String get button_history_of_jiujitsu_home_page;

  /// No description provided for @button_rules_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'Rules'**
  String get button_rules_home_page;

  /// No description provided for @button_quiz_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'Quiz'**
  String get button_quiz_home_page;

  /// No description provided for @button_fight_marker_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'Fight marker'**
  String get button_fight_marker_home_page;

  /// No description provided for @button_wallpapers_home_page.
  ///
  /// In en_US, this message translates to:
  /// **'Wallpapers'**
  String get button_wallpapers_home_page;

  /// No description provided for @title_appbar_settings_page.
  ///
  /// In en_US, this message translates to:
  /// **'Settings'**
  String get title_appbar_settings_page;

  /// No description provided for @button_credits_settings_page.
  ///
  /// In en_US, this message translates to:
  /// **'Credits'**
  String get button_credits_settings_page;

  /// No description provided for @button_language_settings_page.
  ///
  /// In en_US, this message translates to:
  /// **'Languages'**
  String get button_language_settings_page;

  /// No description provided for @text_brazilian_portuguese.
  ///
  /// In en_US, this message translates to:
  /// **'Brazilian Portuguese'**
  String get text_brazilian_portuguese;

  /// No description provided for @text_english_united_states.
  ///
  /// In en_US, this message translates to:
  /// **'Englis United States'**
  String get text_english_united_states;

  /// No description provided for @text_notice_popup.
  ///
  /// In en_US, this message translates to:
  /// **'Close and open the app so that the language change is done completely.'**
  String get text_notice_popup;

  /// No description provided for @text_continue_popup.
  ///
  /// In en_US, this message translates to:
  /// **'Continue'**
  String get text_continue_popup;

  /// No description provided for @text_version.
  ///
  /// In en_US, this message translates to:
  /// **'Version'**
  String get text_version;

  /// No description provided for @text_contact.
  ///
  /// In en_US, this message translates to:
  /// **'Contact'**
  String get text_contact;

  /// No description provided for @text_about_the_app.
  ///
  /// In en_US, this message translates to:
  /// **'About the app'**
  String get text_about_the_app;

  /// No description provided for @text_rate_the_app.
  ///
  /// In en_US, this message translates to:
  /// **'Rate the app'**
  String get text_rate_the_app;

  /// No description provided for @text_cancel.
  ///
  /// In en_US, this message translates to:
  /// **'Cancel'**
  String get text_cancel;

  /// No description provided for @title_appbar_credits_page.
  ///
  /// In en_US, this message translates to:
  /// **'Credits'**
  String get title_appbar_credits_page;

  /// No description provided for @text_all_application_icons_are_from_flaticon.
  ///
  /// In en_US, this message translates to:
  /// **'All application icons are from Flaticon.'**
  String get text_all_application_icons_are_from_flaticon;

  /// No description provided for @text_the_application_was_developed_in_flutter.
  ///
  /// In en_US, this message translates to:
  /// **'The application was developed in flutter.'**
  String get text_the_application_was_developed_in_flutter;

  /// No description provided for @text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons.
  ///
  /// In en_US, this message translates to:
  /// **'If you want to know both the Flutter and the Flaticon, just click on the icons.'**
  String
      get text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons;

  /// No description provided for @history_of_jiujitsu_page_summary.
  ///
  /// In en_US, this message translates to:
  /// **'Jiu-jitsu has several stories about its origins. The most accepted one is that it originated in Japan, while another, less recognized, suggests that its roots are in India. Here, you will learn about both versions in detail.'**
  String get history_of_jiujitsu_page_summary;

  /// No description provided for @title_appbar_history_of_jiujitsu_page.
  ///
  /// In en_US, this message translates to:
  /// **'History of Jiu-jitsu'**
  String get title_appbar_history_of_jiujitsu_page;

  /// No description provided for @button_jiujitsu_in_japao.
  ///
  /// In en_US, this message translates to:
  /// **'O Jiu-jitsu no Japão'**
  String get button_jiujitsu_in_japao;

  /// No description provided for @button_jiujitsu_in_india.
  ///
  /// In en_US, this message translates to:
  /// **'O Jiu-jitsu na India'**
  String get button_jiujitsu_in_india;

  /// No description provided for @button_jiujitsu_in_brazil.
  ///
  /// In en_US, this message translates to:
  /// **'O Jiu-jitsu no Brasil'**
  String get button_jiujitsu_in_brazil;

  /// No description provided for @title_appbar_rule_page.
  ///
  /// In en_US, this message translates to:
  /// **'Rules'**
  String get title_appbar_rule_page;

  /// No description provided for @button_basic_rules.
  ///
  /// In en_US, this message translates to:
  /// **'Basic rules'**
  String get button_basic_rules;

  /// No description provided for @button_cbjj_Rules.
  ///
  /// In en_US, this message translates to:
  /// **'CBJJ rules'**
  String get button_cbjj_Rules;

  /// No description provided for @title_appbar_quiz_page.
  ///
  /// In en_US, this message translates to:
  /// **'Quiz'**
  String get title_appbar_quiz_page;

  /// No description provided for @button_white_belt_level.
  ///
  /// In en_US, this message translates to:
  /// **'White Belt Level'**
  String get button_white_belt_level;

  /// No description provided for @button_blue_belt_level.
  ///
  /// In en_US, this message translates to:
  /// **'Blue Belt Level'**
  String get button_blue_belt_level;

  /// No description provided for @button_black_belt_level.
  ///
  /// In en_US, this message translates to:
  /// **'Black Belt Level'**
  String get button_black_belt_level;

  /// No description provided for @title_appbar_fightmarker_page.
  ///
  /// In en_US, this message translates to:
  /// **'Fight marker'**
  String get title_appbar_fightmarker_page;

  /// No description provided for @text_label_time_popup.
  ///
  /// In en_US, this message translates to:
  /// **'Time'**
  String get text_label_time_popup;

  /// No description provided for @text_label_cancel_popup.
  ///
  /// In en_US, this message translates to:
  /// **'Cancel'**
  String get text_label_cancel_popup;

  /// No description provided for @text_label_continue.
  ///
  /// In en_US, this message translates to:
  /// **'Continue'**
  String get text_label_continue;

  /// No description provided for @text_button_stopsound.
  ///
  /// In en_US, this message translates to:
  /// **'Stop sound'**
  String get text_button_stopsound;

  /// No description provided for @text_abbreviated_advantage.
  ///
  /// In en_US, this message translates to:
  /// **'A'**
  String get text_abbreviated_advantage;

  /// No description provided for @text_abbreviated_punishment.
  ///
  /// In en_US, this message translates to:
  /// **'P'**
  String get text_abbreviated_punishment;

  /// No description provided for @title_appbar_wallpapers.
  ///
  /// In en_US, this message translates to:
  /// **'Wallpapers'**
  String get title_appbar_wallpapers;

  /// No description provided for @title_popup_wallpaper.
  ///
  /// In en_US, this message translates to:
  /// **'Use how?'**
  String get title_popup_wallpaper;

  /// No description provided for @text_popup_save_wallpaper.
  ///
  /// In en_US, this message translates to:
  /// **'Use wallpaper'**
  String get text_popup_save_wallpaper;

  /// No description provided for @text_popup_set_home.
  ///
  /// In en_US, this message translates to:
  /// **'Home Screen'**
  String get text_popup_set_home;

  /// No description provided for @text_popup_set_block.
  ///
  /// In en_US, this message translates to:
  /// **'Lockscreen'**
  String get text_popup_set_block;

  /// No description provided for @text_popup_set_both.
  ///
  /// In en_US, this message translates to:
  /// **'Both Screens'**
  String get text_popup_set_both;

  /// No description provided for @text_popup_error.
  ///
  /// In en_US, this message translates to:
  /// **'Something went wrong :/'**
  String get text_popup_error;

  /// No description provided for @text_popup_saved.
  ///
  /// In en_US, this message translates to:
  /// **'Done!'**
  String get text_popup_saved;

  /// No description provided for @title_appbar_jiujitsu_in_japan_page.
  ///
  /// In en_US, this message translates to:
  /// **'Origem do Jiu-jitsu(Japan)'**
  String get title_appbar_jiujitsu_in_japan_page;

  /// No description provided for @text_jiujitsu_in_japan_paragraph1.
  ///
  /// In en_US, this message translates to:
  /// **'Jiu-jitsu, also known by the spellings jujutsu, jujitsu, or yawara, originated in feudal Japan as a combat art focused on survival in wartime situations. Its roots trace back to ancient times, especially during the Yamato period (circa 250–710 AD), when the first hand-to-hand combat techniques began to take shape. Over time, these practices became more established, particularly during the Heian (794–1185) and Kamakura (1185–1333) periods, when the samurai warrior class began to play a central role in Japanese society.'**
  String get text_jiujitsu_in_japan_paragraph1;

  /// No description provided for @text_jiujitsu_in_japan_paragraph2.
  ///
  /// In en_US, this message translates to:
  /// **'Samurai, who were constantly engaged in battles, needed an effective system of defense in case they were disarmed during combat. Thus, they developed techniques that allowed them to neutralize the enemy using their bodies, employing leverage, joint locks, throws, and chokes. The basic principle of jiu-jitsu was the use of softness (ju) to overcome an opponent’s strength—rather than confronting it directly, the practitioner would redirect or absorb it.'**
  String get text_jiujitsu_in_japan_paragraph2;

  /// No description provided for @text_jiujitsu_in_japan_paragraph3.
  ///
  /// In en_US, this message translates to:
  /// **'During the Muromachi period (1336–1573), and especially the Sengoku period (1477–1603), a time marked by intense internal wars, various schools (ryu) of jiu-jitsu began to emerge. Among them were the Takenouchi-ryu, founded in 1532 and one of the oldest documented, as well as the Yagyu Shingan-ryu and Daito-ryu Aiki-jujutsu, which would later influence other martial arts like aikido. These schools taught what is known as koryu jujutsu, a traditional jiu-jitsu aimed at the battlefield, featuring lethal and highly effective techniques.'**
  String get text_jiujitsu_in_japan_paragraph3;

  /// No description provided for @text_jiujitsu_in_japan_paragraph4.
  ///
  /// In en_US, this message translates to:
  /// **'With the unification of Japan under the Tokugawa Shogunate in the early 17th century, the country entered a long period of peace known as the Edo Period (1603–1868). This drastically changed the role of the samurai, who transitioned from warriors to bureaucrats or security guards. Jiu-jitsu also adapted to this new reality: deadly techniques were modified for safer training and directed toward moral and physical development. Dojos multiplied, and the practice came to be seen as a tool for discipline, self-control, and tradition.'**
  String get text_jiujitsu_in_japan_paragraph4;

  /// No description provided for @text_jiujitsu_in_japan_paragraph5.
  ///
  /// In en_US, this message translates to:
  /// **'However, with the Meiji Restoration beginning in 1868, Japan embarked on a process of modernization and Westernization that nearly led to the disappearance of traditional martial arts. The samurai lost their status, and jiu-jitsu came to be seen as obsolete in the face of new weapons and Western ideologies. In this context, the art began to decline, kept alive only by masters dedicated to preserving Japanese martial culture.'**
  String get text_jiujitsu_in_japan_paragraph5;

  /// No description provided for @text_jiujitsu_in_japan_paragraph6.
  ///
  /// In en_US, this message translates to:
  /// **'It was during this transitional period that Jigoro Kano emerged—a teacher and jiu-jitsu practitioner who decided to modernize and systematize the art. In 1882, he founded Kodokan Judo, a martial art derived from traditional jiu-jitsu but focused on moral, educational, and sporting instruction. Kano removed dangerous techniques, emphasized safe training, and introduced a new system of belts and ranks, helping the art survive in modern Japan.'**
  String get text_jiujitsu_in_japan_paragraph6;

  /// No description provided for @text_jiujitsu_in_japan_paragraph7.
  ///
  /// In en_US, this message translates to:
  /// **'Thus, Japanese jiu-jitsu developed over the centuries as a reflection of the needs and transformations of Japanese society. From a battlefield combat technique, it evolved into a philosophy of life and education. Its principles of efficiency, control, and softness remain alive today, whether in traditional schools (koryu), modern judo, or adaptations that gave rise to other forms such as Brazilian jiu-jitsu.'**
  String get text_jiujitsu_in_japan_paragraph7;

  /// No description provided for @title_appbar_origin_of_jiujitsu_india_page.
  ///
  /// In en_US, this message translates to:
  /// **'Origin of Jiu-jitsu (India)'**
  String get title_appbar_origin_of_jiujitsu_india_page;

  /// No description provided for @text_origin_of_jiujitsu_india_paragraph1.
  ///
  /// In en_US, this message translates to:
  /// **'Despite your growing popularity in Japan, the history of jiu-jitsu started on India (that justifies the name “cradle of martial arts”) more than two thousand years ago.'**
  String get text_origin_of_jiujitsu_india_paragraph1;

  /// No description provided for @text_origin_of_jiujitsu_india_paragraph2.
  ///
  /// In en_US, this message translates to:
  /// **'The religion forbade monks Indian monasteries to defend yourself. But when they practiced long walks, they suffered assaults by bandits of Mongolian tribes from North Asia, so the need arose for body-to-body defense.'**
  String get text_origin_of_jiujitsu_india_paragraph2;

  /// No description provided for @text_origin_of_jiujitsu_india_paragraph3.
  ///
  /// In en_US, this message translates to:
  /// **'The specialists of vital points of the human body developed a kind of special defense for his tiny and skinny people. This kind of jiu-jitsu prototypes finally crossed the China borders and tracked to Japan archipelagos where the development was located, but that was known only by nobles and samurais. This prototypes was known as “Soft Art”.'**
  String get text_origin_of_jiujitsu_india_paragraph3;

  /// No description provided for @text_origin_of_jiujitsu_india_paragraph4.
  ///
  /// In en_US, this message translates to:
  /// **'The jiu-jitsu was the most practiced fight in Japan for a long time until the appearance of judo as a sport at 1882, through the master of jiu-jitsu, Jigoro Kano. The judo removes the traumatic techniques from the most dangerous and efficiency jiu-jitsu and create the sport as we know now. However there were still many styles of jiu-jitsu that were also branched by the competitors.'**
  String get text_origin_of_jiujitsu_india_paragraph4;

  /// No description provided for @text_origin_of_jiujitsu_india_paragraph5.
  ///
  /// In en_US, this message translates to:
  /// **'The jiu-jitsu was forbidden in Japan by a while as a crime against your own country. With the introduction of Western culture in Japan promote by the emperor Mutso Hito(1867-1912) the martial arts was forgotten. Until later, when the Western started to appreciate and “import” this fight types.'**
  String get text_origin_of_jiujitsu_india_paragraph5;

  /// No description provided for @title_appbar_jiujitsu_in_brazil_page.
  ///
  /// In en_US, this message translates to:
  /// **'The Brazilian Jiu-jitsu'**
  String get title_appbar_jiujitsu_in_brazil_page;

  /// No description provided for @text_jiujitsu_in_brazil_paragraph1.
  ///
  /// In en_US, this message translates to:
  /// **'The Japanese master, Mitsuo Maeda know as Konde Koma, went to Brazil on a diplomatic mission and in Belem from Para, he knew Gastao Gracie and from that moment emerged a great friendship. Conde Kome by affinity for Gastao started to teach jiu-jitsu to son of Gastao, Carlos Gracie that later taught to his brothes, mainly Helio Gracie. They improved the know techniques, making them more efficiency and available for all kinds of people. This development was based in the introduction of the lever techniques in traditional Japanese techniques.'**
  String get text_jiujitsu_in_brazil_paragraph1;

  /// No description provided for @text_jiujitsu_in_brazil_paragraph2.
  ///
  /// In en_US, this message translates to:
  /// **'Because of your fragile health, Helio, the smaller Gracie, couldn’t train the traditional jiu-jitsu taught by his brothers, how he was an observer, Helio started to follow, from the thirteen to sixteen years, the classes taught by Carlos Greice. Helio learned all the techniques and teachings of his brother but to compensate your biotype, he improved the traditional ground fight by the use of the lever, giving to him the extra strength that lacked, thus creating the Brazilian jiu-jitsu.'**
  String get text_jiujitsu_in_brazil_paragraph2;

  /// No description provided for @text_jiujitsu_in_brazil_paragraph3.
  ///
  /// In en_US, this message translates to:
  /// **'That’s how it was born the Gracie jiu-jitsu also known as the Brazilian jiu-jitsu, the best and most efficient self defense way in the world, proven by the results of constant competitions of MMA existing in the world.'**
  String get text_jiujitsu_in_brazil_paragraph3;

  /// No description provided for @title_appbar_basic_rules_page.
  ///
  /// In en_US, this message translates to:
  /// **'Basic rules'**
  String get title_appbar_basic_rules_page;

  /// No description provided for @text_overview_title.
  ///
  /// In en_US, this message translates to:
  /// **'Overview'**
  String get text_overview_title;

  /// No description provided for @text_overview.
  ///
  /// In en_US, this message translates to:
  /// **'In this category you will learn the basic about the rules of jiu-jitsu championship, to start you need to understand that the fights are divided by weight, belt and age and thereby the rules also has a small change, and It’s essential to say that in jiu-jitsu, traditional attacks isn’t allowed like kicks, punches, knees, elbows and infinity others attacks aren’t allowed too, also exist in championships the famous “absolute” that is a weightless category, only divided by belt and age, remembering that in any fight the completion gives the direct victory and if the time is over without any completions, the fights will be decided by the score, advantages and penalties, in case everything’s tied the decision will be the judge’s.'**
  String get text_overview;

  /// No description provided for @text_scores_title.
  ///
  /// In en_US, this message translates to:
  /// **'Scores'**
  String get text_scores_title;

  /// No description provided for @text_scores.
  ///
  /// In en_US, this message translates to:
  /// **'In jiu-jitsu, the score is divided into 2 score, 3 score and 4 score, also exist the advantages and penalties but we will talk about theirs later.'**
  String get text_scores;

  /// No description provided for @text_moves_that_gives_2_scores_title.
  ///
  /// In en_US, this message translates to:
  /// **'Moves that gives 2 scores'**
  String get text_moves_that_gives_2_scores_title;

  /// No description provided for @text_throws.
  ///
  /// In en_US, this message translates to:
  /// **'Throws → there are many factors for a throw be considered, the throw needs to have a beginning inside the fight area and it’s necessary the 3 seconds stabilization, this applies for any kind of throw.'**
  String get text_throws;

  /// No description provided for @text_knee_in_belly.
  ///
  /// In en_US, this message translates to:
  /// **'Knee in belly → to be considered, needs a 3 seconds stabilization'**
  String get text_knee_in_belly;

  /// No description provided for @text_sweep.
  ///
  /// In en_US, this message translates to:
  /// **'Sweep → a sweep is basically turn over the position from a full guard. Imagine that you are doing the full guard, therefore you are below and you opponent above, in sweep you turn over the position staying above, It’s important that the postion starts with a guard type, you can sweep and stay on top mounted in the opponents guard or with any other way that you prefer, It doesn’t interfere with anything, you just need to let your opponent with your back to mat and stay above, It’s needed to stabilize for 3 seconds to win the throw scores'**
  String get text_sweep;

  /// No description provided for @text_moves_that_gives_3_scores_title.
  ///
  /// In en_US, this message translates to:
  /// **'Moves that gives 3 scores'**
  String get text_moves_that_gives_3_scores_title;

  /// No description provided for @text_moves_that_gives_3_scores.
  ///
  /// In en_US, this message translates to:
  /// **'In jiu-jitsu there is only one move that gives 3 scores.'**
  String get text_moves_that_gives_3_scores;

  /// No description provided for @text_guard_pass.
  ///
  /// In en_US, this message translates to:
  /// **'Guard pass → goes for absolutely any guard type, you will need to get on side control, mount or north south, to win scores it’s need the 3 seconds stabilization'**
  String get text_guard_pass;

  /// No description provided for @text_moves_that_gives_4_scores_title.
  ///
  /// In en_US, this message translates to:
  /// **'Moves that gives 4 scores'**
  String get text_moves_that_gives_4_scores_title;

  /// No description provided for @text_mount.
  ///
  /// In en_US, this message translates to:
  /// **'Mount → any mount type counts to win the scores and needed the 3 seconds stabilization'**
  String get text_mount;

  /// No description provided for @text_backward_grip.
  ///
  /// In en_US, this message translates to:
  /// **'Backward grip → you need to get on opponent back and put the hooks, it’s needed the 3 seconds stabilization'**
  String get text_backward_grip;

  /// No description provided for @text_advantage_and_penalties_title.
  ///
  /// In en_US, this message translates to:
  /// **'Advantage and penalties'**
  String get text_advantage_and_penalties_title;

  /// No description provided for @text_advantage_and_penalties.
  ///
  /// In en_US, this message translates to:
  /// **'The advantage can be decisive, you will win an advantage every time that you represent risk to the opponent, for example, imagine that you almost finalize the opponent or almost throw him, in this case you get an advantage, but remembering, if you succeed the throw you don’t will get an advantage but will get 2 throw scores, scores always will have a bigger weight in the fight decision than the advantages, the advantages serves to tiebreaker if the score’s tied. There are many penalties types, the very serious penalties leads to immediate disqualification, out of that case, if you receive a very serious penalties will be a heaviness in the final decision, if you receive 2 penalties your opponent win an advantage, if you receive 3 penalties your opponent win 2 scores and in the fourth penalty you will be disqualified, there are many situations that can give you a penalty, for example, the lack of competitiveness, but exist many others. If you want to know more about the penalties take a look in rules from CBJJ .'**
  String get text_advantage_and_penalties;

  /// No description provided for @title_appbar_cbjj_rules_page.
  ///
  /// In en_US, this message translates to:
  /// **'CBJJ rules'**
  String get title_appbar_cbjj_rules_page;

  /// No description provided for @title_cbjj_successDownload.
  ///
  /// In en_US, this message translates to:
  /// **'Save successfully!'**
  String get title_cbjj_successDownload;

  /// No description provided for @title_cbjj_failedDownload.
  ///
  /// In en_US, this message translates to:
  /// **'Unable to save PDF :/'**
  String get title_cbjj_failedDownload;

  /// No description provided for @text_difficultyname_white_belt.
  ///
  /// In en_US, this message translates to:
  /// **'White Belt'**
  String get text_difficultyname_white_belt;

  /// No description provided for @text_difficultyname_blue_belt.
  ///
  /// In en_US, this message translates to:
  /// **'Blue Belt'**
  String get text_difficultyname_blue_belt;

  /// No description provided for @text_difficultyname_black_belt.
  ///
  /// In en_US, this message translates to:
  /// **'Black Belt'**
  String get text_difficultyname_black_belt;

  /// No description provided for @text_question.
  ///
  /// In en_US, this message translates to:
  /// **'Question'**
  String get text_question;

  /// No description provided for @text_result_quiz_white_belt.
  ///
  /// In en_US, this message translates to:
  /// **'His black white quiz score was:'**
  String get text_result_quiz_white_belt;

  /// No description provided for @text_result_quiz_blue_belt.
  ///
  /// In en_US, this message translates to:
  /// **'His blue belt quiz score was:'**
  String get text_result_quiz_blue_belt;

  /// No description provided for @text_result_quiz_black_belt.
  ///
  /// In en_US, this message translates to:
  /// **'His black belt quiz score was:'**
  String get text_result_quiz_black_belt;

  /// No description provided for @text_message_quiz_very_well.
  ///
  /// In en_US, this message translates to:
  /// **'Oss, did very well!!!'**
  String get text_message_quiz_very_well;

  /// No description provided for @text_message_quiz_almost.
  ///
  /// In en_US, this message translates to:
  /// **'Almost, study more.'**
  String get text_message_quiz_almost;

  /// No description provided for @text_message_quiz_sad.
  ///
  /// In en_US, this message translates to:
  /// **'It was not this time.'**
  String get text_message_quiz_sad;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
