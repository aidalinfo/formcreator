<?php
/**
 * ---------------------------------------------------------------------
 * Formcreator is a plugin which allows creation of custom forms of
 * easy access.
 * ---------------------------------------------------------------------
 * LICENSE
 *
 * This file is part of Formcreator.
 *
 * Formcreator is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Formcreator is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Formcreator. If not, see <http://www.gnu.org/licenses/>.
 * ---------------------------------------------------------------------
 * @copyright Copyright © 2011 - 2021 Teclib'
 * @license   http://www.gnu.org/licenses/gpl.txt GPLv3+
 * @link      https://github.com/pluginsGLPI/formcreator/
 * @link      https://pluginsglpi.github.io/formcreator/
 * @link      http://plugins.glpi-project.org/#/plugin/formcreator
 * ---------------------------------------------------------------------
 */
class PluginFormcreatorUpgradeTo2_14_1 {
   /** @var Migration */
   protected $migration;

   /**
    * @param Migration $migration
    */
   public function upgrade(Migration $migration) {
       $this->migration = $migration;

       $this->addEditDisabledToQuestions();
   }

   /**
    * Add edit_disabled field to questions table
    * This field allows to make questions read-only while still allowing URL pre-filling
    */
   public function addEditDisabledToQuestions() {
      $table = 'glpi_plugin_formcreator_questions';

      // Add the edit_disabled field
      $this->migration->addField(
         $table,
         'edit_disabled',
         'bool', [
            'after' => 'required',
            'value' => '0',
         ]
      );

      // Add index for performance
      $this->migration->addKey($table, 'edit_disabled');

      // Execute the migration
      $this->migration->executeMigration();
   }
}