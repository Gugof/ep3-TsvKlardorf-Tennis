<?php
/**
 * Local application configuration
 *
 * Insert your local database credentials here
 * and provide the email address the system should use.
 */

return [
    'db' => [
        'database' => 'ep3',
        'username' => 'ep3',
        'password' => 'ep3',

        'hostname' => 'db',
        'port' => null,
    ],
    'mail' => [
        'type' => 'smtp',
        'address' => 'buchung@tsv-klardorf.de',
        'host' => 'mailpit',
        'user' => '',
        'pw' => '',
        'port' => 1025,
        'auth' => 'none',
    ],
    'i18n' => [
        'choice' => [
            // deativated cause only one language is supported at the moment
            //'en-US' => 'English',
            //'de-DE' => 'Deutsch',

            // More possible languages:
            // 'fr-FR' => 'Français',
            // 'hu-HU' => 'Magyar',
        ],

        'currency' => 'EUR',

        // The language is usually detected from the user's web browser.
        // If it cannot be detected automatically and there is no cookie from a manual language selection,
        // the following locale will be used as the default "fallback":
        'locale' => 'de-DE',
    ],
];
