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

if (!defined('GLPI_ROOT')) {
   die("Sorry. You can't access this file directly");
}

trait PluginFormcreatorUrlParametersTrait
{
   /**
    * Check if the field has input from either form submission or URL parameters
    * @param array $input Form input data
    * @return bool
    */
   public function hasInputWithUrlSupport($input): bool {
      // First check standard form input
      $fieldKey = 'formcreator_field_' . $this->question->getID();
      if (isset($input[$fieldKey])) {
         return true;
      }
      
      // Then check URL parameters
      $urlFieldKey = 'field_' . $this->question->fields['name'];
      if (isset($_GET[$urlFieldKey])) {
         // Add URL parameter to input for processing
         $input[$fieldKey] = $_GET[$urlFieldKey];
         return true;
      }
      
      return false;
   }
}