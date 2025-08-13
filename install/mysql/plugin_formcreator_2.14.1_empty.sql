CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_answers` (
	`id`                           int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_formanswers_id` int unsigned NOT NULL DEFAULT '0',
	`plugin_formcreator_questions_id`   int unsigned NOT NULL DEFAULT '0',
	`answer`                             longtext,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_formanswers_id` (`plugin_formcreator_formanswers_id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_categories` (
	`id`                               int unsigned NOT NULL AUTO_INCREMENT,
	`name`                             varchar(255) NOT NULL DEFAULT '',
	`comment`                          text,
	`completename`                     text,
	`plugin_formcreator_categories_id` int unsigned NOT NULL DEFAULT '0',
	`level`                            int(11)      NOT NULL DEFAULT '1',
	`sons_cache`                       longtext,
	`ancestors_cache`                  longtext,
	`knowbaseitemcategories_id`        int unsigned NOT NULL DEFAULT '0',
	`is_helpdesk_visible`              int NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`),
	INDEX `name` (`name`),
	INDEX `knowbaseitemcategories_id` (`knowbaseitemcategories_id`),
	INDEX `plugin_formcreator_categories_id` (`plugin_formcreator_categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_conditions` (
	`id`                              int unsigned NOT NULL AUTO_INCREMENT,
	`itemtype`                        varchar(255) NOT NULL DEFAULT '' COMMENT 'itemtype of the item affected by the condition',
	`items_id`                        int unsigned NOT NULL DEFAULT '0' COMMENT 'item ID of the item affected by the condition',
	`plugin_formcreator_questions_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'question to test for the condition',
	`show_condition`                  int(11)      NOT NULL DEFAULT '0',
	`show_value`                      mediumtext   NULL DEFAULT NULL,
	`show_logic`                      int(11)      NOT NULL DEFAULT '1',
	`order`                           int(11)      NOT NULL DEFAULT '1',
	`uuid`                            varchar(255) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`),
	INDEX `item` (`itemtype`, `items_id`),
	KEY `show_logic` (`show_logic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_forms` (
	`id`                               int unsigned NOT NULL AUTO_INCREMENT,
	`name`                             varchar(255) NOT NULL DEFAULT '',
	`entities_id`                      int unsigned NOT NULL DEFAULT '0',
	`is_recursive`                     tinyint(1)   NOT NULL DEFAULT '0',
	`icon`                             varchar(255) NOT NULL DEFAULT '',
	`icon_color`                       varchar(255) NOT NULL DEFAULT '',
	`background_color`                 varchar(255) NOT NULL DEFAULT '',
	`access_rights`                    tinyint(1)   NOT NULL DEFAULT '1',
	`description`                      varchar(255) DEFAULT NULL,
	`content`                          longtext,
	`plugin_formcreator_categories_id` int unsigned NOT NULL DEFAULT '0',
	`is_active`                        tinyint(1)   NOT NULL DEFAULT '0',
	`language`                         varchar(255) NOT NULL DEFAULT '',
	`helpdesk_home`                    tinyint(1)   NOT NULL DEFAULT '0',
	`is_deleted`                       tinyint(1)   NOT NULL DEFAULT '0',
	`validation_required`              tinyint(1)   NOT NULL DEFAULT '0',
	`is_visible`                       tinyint(1)   NOT NULL DEFAULT '1',
	`is_default`                       tinyint(1)   NOT NULL DEFAULT '0',
	`is_captcha_enabled`               tinyint(1)   NOT NULL DEFAULT '0',
	`show_rule`                        int(11)      NOT NULL DEFAULT '0' COMMENT 'Conditions setting to show the form',
	`formanswer_name`                  varchar(255) NOT NULL DEFAULT '',
	`is_kb_separated`                  tinyint(1)   NOT NULL DEFAULT '0',
	`is_search_visible`                tinyint(1)   NOT NULL DEFAULT '1',
	`is_dashboard_visible`             tinyint(1)   NOT NULL DEFAULT '1',
	`max_submit`                       int unsigned NOT NULL DEFAULT '0',
	`is_timezones_enabled`             tinyint(1) NOT NULL DEFAULT '0',
	`usage_count`                      int(11)      NOT NULL DEFAULT '0',
	`is_header_visible`                tinyint(1)   NOT NULL DEFAULT '0',
	`uuid`                             varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `entities_id` (`entities_id`),
	INDEX `plugin_formcreator_categories_id` (`plugin_formcreator_categories_id`),
	FULLTEXT KEY `Search` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_formanswers` (
	`id`                          int unsigned NOT NULL AUTO_INCREMENT,
	`name`                        varchar(255) NOT NULL DEFAULT '',
	`entities_id`                 int unsigned NOT NULL DEFAULT '0',
	`is_recursive`                tinyint(1)   NOT NULL DEFAULT '0',
	`plugin_formcreator_forms_id` int unsigned NOT NULL,
	`requester_id`                int unsigned NOT NULL DEFAULT '0',
	`users_id_validator`          int unsigned NOT NULL DEFAULT '0' COMMENT 'User in charge of validation',
	`groups_id_validator`         int unsigned NOT NULL DEFAULT '0' COMMENT 'Group in charge of validation',
	`request_date`                timestamp NULL,
	`status`                      int(11)      NOT NULL DEFAULT '101',
	`comment`                     text,
	`is_answered`                 tinyint(1)   NOT NULL DEFAULT '0',
	`refused_comment`             text,
	`answered_time`               text,
	`total_answered_time`         int(11)      NOT NULL DEFAULT '0',
	`timezone`                    varchar(255) NOT NULL DEFAULT '',
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_forms_id` (`plugin_formcreator_forms_id`),
	INDEX `entities_id` (`entities_id`),
	INDEX `is_recursive` (`is_recursive`),
	INDEX `requester_id` (`requester_id`),
	INDEX `users_id_validator` (`users_id_validator`),
	INDEX `groups_id_validator` (`groups_id_validator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_formanswers_validators` (
	`id`                                 int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_formanswers_id` int unsigned NOT NULL,
	`items_id`                           int unsigned NOT NULL DEFAULT '0',
	`itemtype`                           varchar(255) NOT NULL DEFAULT '',
	`comment`                            text,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_formanswers_id` (`plugin_formcreator_formanswers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_forms_profiles` (
	`id`                          int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_forms_id` int unsigned NOT NULL,
	`profiles_id`                 int unsigned NOT NULL,
	`uuid`                        varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`profiles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_forms_users` (
	`id`                          int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_forms_id` int unsigned NOT NULL,
	`users_id`                    int unsigned NOT NULL,
	`uuid`                        varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_forms_groups` (
	`id`                          int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_forms_id` int unsigned NOT NULL,
	`groups_id`                   int unsigned NOT NULL,
	`uuid`                        varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_forms_validators` (
	`id`                          int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_forms_id` int unsigned NOT NULL,
	`itemtype`                    varchar(255) NOT NULL DEFAULT '',
	`items_id`                    int unsigned NOT NULL,
	`uuid`                        varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_questions` (
  `id`                             int unsigned NOT NULL AUTO_INCREMENT,
  `name`                           varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_sections_id` int unsigned NOT NULL DEFAULT '0',
  `fieldtype`                      varchar(30)  NOT NULL DEFAULT 'text',
  `required`                       tinyint(1)   NOT NULL DEFAULT '0',
  `edit_disabled`                  tinyint(1)   NOT NULL DEFAULT '0' COMMENT 'If true, the field cannot be edited by users but can still be pre-filled via URL',
  `show_empty`                     tinyint(1)   NOT NULL DEFAULT '0',
  `default_values`                 mediumtext,
  `itemtype`                       varchar(255) NOT NULL DEFAULT '' COMMENT 'itemtype used for glpi objects and dropdown question types',
  `values`                         mediumtext,
  `description`                    mediumtext,
  `row`                            int(11)      NOT NULL DEFAULT '0',
  `col`                            int(11)      NOT NULL DEFAULT '0',
  `width`                          int(11)      NOT NULL DEFAULT '0',
  `show_rule`                      int(11)      NOT NULL DEFAULT '1',
  `uuid`                           varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `plugin_formcreator_sections_id` (`plugin_formcreator_sections_id`),
  FULLTEXT KEY `Search` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_conditions` (
	`id`                              int unsigned NOT NULL AUTO_INCREMENT,
	`itemtype`                        varchar(255) NOT NULL DEFAULT '' COMMENT 'itemtype of the item affected by the condition',
	`items_id`                        int unsigned NOT NULL DEFAULT '0' COMMENT 'item ID of the item affected by the condition',
	`plugin_formcreator_questions_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'question to test for the condition',
	`show_condition`                  int(11)      NOT NULL DEFAULT '0',
	`show_value`                      mediumtext   NULL DEFAULT NULL,
	`show_logic`                      int(11)      NOT NULL DEFAULT '1',
	`order`                           int(11)      NOT NULL DEFAULT '1',
	`uuid`                            varchar(255) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`),
	INDEX `item` (`itemtype`, `items_id`),
	KEY `show_logic` (`show_logic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_questiondependencies` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_questions_id`        int unsigned NOT NULL,
	`plugin_formcreator_questions_id_2`      int unsigned NOT NULL,
	`fieldname`                               varchar(255) DEFAULT NULL,
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`),
	INDEX `plugin_formcreator_questions_id_2` (`plugin_formcreator_questions_id_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_questionregexes` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_questions_id`        int unsigned NOT NULL,
	`regex`                                   text DEFAULT NULL,
	`fieldname`                               varchar(255) DEFAULT NULL,
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_questionranges` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_questions_id`        int unsigned NOT NULL,
	`range_min`                               varchar(255) DEFAULT NULL,
	`range_max`                               varchar(255) DEFAULT NULL,
	`fieldname`                               varchar(255) DEFAULT NULL,
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_sections` (
	`id`                               int unsigned NOT NULL AUTO_INCREMENT,
	`name`                             varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`      int unsigned NOT NULL,
	`order`                            int(11)      NOT NULL DEFAULT '0',
	`show_rule`                        int(11)      NOT NULL DEFAULT '1' COMMENT 'Conditions setting to show the section',
	`uuid`                             varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_forms_id` (`plugin_formcreator_forms_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_targets` (
	`id`                           int unsigned NOT NULL AUTO_INCREMENT,
	`name`                         varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`  int unsigned NOT NULL,
	`itemtype`                     varchar(255) NOT NULL DEFAULT '',
	`items_id`                     int unsigned NOT NULL DEFAULT '0',
	`uuid`                         varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_forms_id` (`plugin_formcreator_forms_id`),
	INDEX `itemtype_items_id` (`itemtype`, `items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_targetchanges` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`name`                                    varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`             int unsigned NOT NULL DEFAULT '0',
	`target_name`                             varchar(255) NOT NULL DEFAULT '',
	`changetemplates_id`                      int unsigned NOT NULL DEFAULT '0',
	`content`                                 longtext,
	`impactcontent`                           longtext,
	`controlistcontent`                       longtext,
	`rolloutplancontent`                      longtext,
	`backoutplancontent`                      longtext,
	`checklistcontent`                        longtext,
	`due_date_rule`                           int(11)      NOT NULL DEFAULT '1',
	`due_date_question`                       int unsigned NOT NULL DEFAULT '0',
	`due_date_value`                          tinyint(4)   DEFAULT NULL,
	`due_date_period`                         int(11)      NOT NULL DEFAULT '0',
	`urgency_rule`                            int(11)      NOT NULL DEFAULT '1',
	`urgency_question`                        int unsigned NOT NULL DEFAULT '0',
	`validation_followup`                     tinyint(1)   NOT NULL DEFAULT '1',
	`destination_entity`                      int(11)      NOT NULL DEFAULT '1',
	`destination_entity_value`                int unsigned NOT NULL DEFAULT '0',
	`tag_type`                                int(11)      NOT NULL DEFAULT '1',
	`tag_questions`                           text,
	`tag_specifics`                           text,
	`category_rule`                           int(11)      NOT NULL DEFAULT '1',
	`category_question`                       int unsigned NOT NULL DEFAULT '0',
	`commonitil_validation_rule`              int(11)      NOT NULL DEFAULT '1',
	`commonitil_validation_question`          varchar(255) DEFAULT NULL,
	`show_rule`                               int(11)      NOT NULL DEFAULT '1',
	`sla_rule`                                int(11)      NOT NULL DEFAULT '1',
	`sla_question_tto`                        int unsigned NOT NULL DEFAULT '0',
	`sla_question_ttr`                        int unsigned NOT NULL DEFAULT '0',
	`ola_rule`                                int(11)      NOT NULL DEFAULT '1',
	`ola_question_tto`                        int unsigned NOT NULL DEFAULT '0',
	`ola_question_ttr`                        int unsigned NOT NULL DEFAULT '0',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_targettickets` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`name`                                    varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`             int unsigned NOT NULL DEFAULT '0',
	`target_name`                             varchar(255) NOT NULL DEFAULT '',
	`source_rule`                             int(11)      NOT NULL DEFAULT '0',
	`source_question`                         int(11)      NOT NULL DEFAULT '0',
	`type_rule`                               int(11)      NOT NULL DEFAULT '0',
	`type_question`                           int unsigned NOT NULL DEFAULT '0',
	`tickettemplates_id`                      int unsigned NOT NULL DEFAULT '0',
	`content`                                 longtext,
	`due_date_rule`                           int(11)      NOT NULL DEFAULT '1',
	`due_date_question`                       int unsigned NOT NULL DEFAULT '0',
	`due_date_value`                          tinyint(4)   DEFAULT NULL,
	`due_date_period`                         int(11)      NOT NULL DEFAULT '0',
	`urgency_rule`                            int(11)      NOT NULL DEFAULT '1',
	`urgency_question`                        int unsigned NOT NULL DEFAULT '0',
	`validation_followup`                     tinyint(1)   NOT NULL DEFAULT '1',
	`destination_entity`                      int(11)      NOT NULL DEFAULT '1',
	`destination_entity_value`                int unsigned NOT NULL DEFAULT '0',
	`tag_type`                                int(11)      NOT NULL DEFAULT '1',
	`tag_questions`                           text,
	`tag_specifics`                           text,
	`category_rule`                           int(11)      NOT NULL DEFAULT '1',
	`category_question`                       int unsigned NOT NULL DEFAULT '0',
	`associate_rule`                          int(11)      NOT NULL DEFAULT '1',
	`associate_question`                      int unsigned NOT NULL DEFAULT '0',
	`location_rule`                           int(11)      NOT NULL DEFAULT '1',
	`location_question`                       int unsigned NOT NULL DEFAULT '0',
	`commonitil_validation_rule`              int(11)      NOT NULL DEFAULT '1',
	`commonitil_validation_question`          varchar(255) DEFAULT NULL,
	`link_ticket_rule`                        int(11)      NOT NULL DEFAULT '1',
	`link_ticket_question`                    int unsigned NOT NULL DEFAULT '0',
	`show_rule`                               int(11)      NOT NULL DEFAULT '1',
	`sla_rule`                                int(11)      NOT NULL DEFAULT '1',
	`sla_question_tto`                        int unsigned NOT NULL DEFAULT '0',
	`sla_question_ttr`                        int unsigned NOT NULL DEFAULT '0',
	`ola_rule`                                int(11)      NOT NULL DEFAULT '1',
	`ola_question_tto`                        int unsigned NOT NULL DEFAULT '0',
	`ola_question_ttr`                        int unsigned NOT NULL DEFAULT '0',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `tickettemplates_id` (`tickettemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_targetproblems` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`name`                                    varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`             int unsigned NOT NULL DEFAULT '0',
	`target_name`                             varchar(255) NOT NULL DEFAULT '',
	`problemtemplates_id`                     int unsigned NOT NULL DEFAULT '0',
	`content`                                 longtext,
	`impactcontent`                           longtext,
	`causecontent`                            longtext,
	`symptomcontent`                          longtext,
	`urgency_rule`                            int(11)      NOT NULL DEFAULT '1',
	`urgency_question`                        int unsigned NOT NULL DEFAULT '0',
	`destination_entity`                      int(11)      NOT NULL DEFAULT '1',
	`destination_entity_value`                int unsigned NOT NULL DEFAULT '0',
	`tag_type`                                int(11)      NOT NULL DEFAULT '1',
	`tag_questions`                           text,
	`tag_specifics`                           text,
	`category_rule`                           int(11)      NOT NULL DEFAULT '1',
	`category_question`                       int unsigned NOT NULL DEFAULT '0',
	`show_rule`                               int(11)      NOT NULL DEFAULT '1',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_target_actors` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`itemtype`                                varchar(255) DEFAULT NULL,
	`items_id`                                int unsigned NOT NULL,
	`actor_role`                              int(11)      NOT NULL DEFAULT '1',
	`actor_type`                              int(11)      NOT NULL DEFAULT '1',
	`actor_value`                             int unsigned NOT NULL DEFAULT '0',
	`use_notification`                        tinyint(1)   NOT NULL DEFAULT '1',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `item` (`itemtype`, `items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_issues` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`name`                                    varchar(255) NULL DEFAULT NULL,
	`display_id`                              varchar(255) NOT NULL,
	`items_id`                                int unsigned NOT NULL DEFAULT '0',
	`itemtype`                                varchar(255) NOT NULL DEFAULT '',
	`status`                                  varchar(255) NOT NULL DEFAULT '',
	`date_creation`                           timestamp NULL,
	`date_mod`                                timestamp NULL,
	`entities_id`                             int unsigned NOT NULL DEFAULT '0',
	`is_recursive`                            tinyint(1)   NOT NULL DEFAULT '0',
	`requester_id`                            int unsigned NOT NULL DEFAULT '0',
	`users_id_validator`                      int unsigned NOT NULL DEFAULT '0' COMMENT 'User in charge of validation',
	`groups_id_validator`                     int unsigned NOT NULL DEFAULT '0' COMMENT 'Group in charge of validation',
	`users_id_recipient`                      int unsigned NOT NULL DEFAULT '0' COMMENT 'User who received the issue',
	`comment`                                 longtext,
	`takeintoaccount_delay_stat`              int(11)      DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `item` (`itemtype`, `items_id`),
	INDEX `entities_id` (`entities_id`),
	INDEX `requester_id` (`requester_id`),
	INDEX `users_id_validator` (`users_id_validator`),
	INDEX `groups_id_validator` (`groups_id_validator`),
	INDEX `users_id_recipient` (`users_id_recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_items_targettickets` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_targettickets_id`    int unsigned NOT NULL DEFAULT '0',
	`link`                                    int(11)      NOT NULL DEFAULT '0',
	`itemtype`                                varchar(255) NOT NULL DEFAULT '',
	`items_id`                                int unsigned NOT NULL DEFAULT '0',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `plugin_formcreator_targettickets_id` (`plugin_formcreator_targettickets_id`),
	INDEX `item` (`itemtype`, `items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_configs` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`header`                                  varchar(255) NULL DEFAULT NULL,
	`service_catalog_home`                   int(11)      NOT NULL DEFAULT '0',
	`vertical_tabs`                           int(11)      NOT NULL DEFAULT '0',
	`replace_helpdesk`                        int(11)      NOT NULL DEFAULT '1',
	`back_button`                             int(11)      NOT NULL DEFAULT '0',
	`github_token`                            varchar(255) NULL DEFAULT NULL,
	`kb_create_default`                       int(11)      NOT NULL DEFAULT '0',
	`see_all`                                 int(11)      NOT NULL DEFAULT '1',
	`sort_order`                              int(11)      NOT NULL DEFAULT '0',
	`tile_design`                             int(11)      NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_entityconfigs` (
	`id`                            int unsigned NOT NULL AUTO_INCREMENT,
	`entities_id`                   int unsigned NOT NULL DEFAULT '0',
	`replace_helpdesk`              int(11)      NOT NULL DEFAULT '-2',
	`sort_order`                    int(11)      NOT NULL DEFAULT '-2',
	`is_kb_separated`               int(11)      NOT NULL DEFAULT '-2',
	`is_search_visible`             int(11)      NOT NULL DEFAULT '-2',
	`is_dashboard_visible`          int(11)      NOT NULL DEFAULT '-2',
	`is_header_visible`             int(11)      NOT NULL DEFAULT '-2',
	`is_captcha_enabled`            int(11)      NOT NULL DEFAULT '-2',
	`service_catalog_home`          int(11)      NOT NULL DEFAULT '-2',
	`header`                        text     NULL DEFAULT NULL,
	`defaults_header`               tinyint(1) NOT NULL DEFAULT '0',
	`is_folded`                     int(11) NOT NULL DEFAULT '0',
	`tile_design`                   int(11)      NOT NULL DEFAULT '-2',
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_targetcontracts` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`name`                                    varchar(255) NOT NULL DEFAULT '',
	`plugin_formcreator_forms_id`             int unsigned NOT NULL DEFAULT '0',
	`target_name`                             varchar(255) NOT NULL DEFAULT '',
	`content`                                 longtext,
	`tag_type`                                int(11)      NOT NULL DEFAULT '1',
	`tag_questions`                           text,
	`tag_specifics`                           text,
	`show_rule`                               int(11)      NOT NULL DEFAULT '1',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `glpi_plugin_formcreator_form_links` (
	`id`                                      int unsigned NOT NULL AUTO_INCREMENT,
	`plugin_formcreator_forms_id`             int unsigned NOT NULL DEFAULT '0',
	`items_id`                                int unsigned NOT NULL DEFAULT '0',
	`itemtype`                                varchar(255) NOT NULL DEFAULT '',
	`uuid`                                    varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `glpi_plugin_formcreator_configs` (`id`, `header`, `service_catalog_home`, `replace_helpdesk`, `back_button`) VALUES (1, 'GLPI Service Catalog', 0, 1, 0);

INSERT INTO `glpi_crontasks` (`itemtype`, `name`, `frequency`, `param`, `state`, `mode`, `allowmode`, `logs_lifetime`, `lastrun`, `lastcode`, `comment`) 
VALUES ('PluginFormcreatorIssue', 'SyncIssues', 86400, 100, 0, 1, 3, 30, NULL, NULL, 'Formcreator issue synchronization');