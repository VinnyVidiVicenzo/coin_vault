<?php
/**
 * Plugin Name: Coin Vault
 * Description: Sync your Coin Vault collection to WordPress. Each coin becomes a custom post with full metadata.
 * Version: 1.0.0
 * Author: Vincenzo Fazeli
 * License: GPL v2 or later
 * Requires at least: 5.6
 * Requires PHP: 7.4
 */

if ( ! defined( 'ABSPATH' ) ) exit;

// ── Custom post type ──────────────────────────────────────────────────

add_action( 'init', function () {
    register_post_type( 'coin_vault_item', [
        'labels' => [
            'name'               => 'Coins',
            'singular_name'      => 'Coin',
            'add_new_item'       => 'Add New Coin',
            'edit_item'          => 'Edit Coin',
            'view_item'          => 'View Coin',
            'search_items'       => 'Search Coins',
            'not_found'          => 'No coins found',
            'not_found_in_trash' => 'No coins in trash',
        ],
        'public'              => true,
        'show_in_rest'        => true,
        'rest_base'           => 'coins',
        'supports'            => [ 'title', 'editor', 'thumbnail', 'custom-fields' ],
        'has_archive'         => true,
        'rewrite'             => [ 'slug' => 'coins' ],
        'menu_icon'           => 'dashicons-awards',
    ] );
} );

// ── Register meta fields ──────────────────────────────────────────────

add_action( 'init', function () {
    $string_fields = [
        'cv_item_id', 'cv_country', 'cv_issuing_authority', 'cv_denomination',
        'cv_mint_mark', 'cv_series', 'cv_variety', 'cv_metal', 'cv_edge_type',
        'cv_coin_orientation', 'cv_obverse_description', 'cv_reverse_description',
        'cv_edge_description', 'cv_die_markers', 'cv_grade', 'cv_grading_company',
        'cv_cert_number', 'cv_designation', 'cv_submission_status',
        'cv_historical_context', 'cv_attribution_notes', 'cv_provenance',
        'cv_internal_notes', 'cv_item_type',
    ];
    foreach ( $string_fields as $key ) {
        register_post_meta( 'coin_vault_item', $key, [
            'type'         => 'string',
            'single'       => true,
            'show_in_rest' => true,
        ] );
    }

    $number_fields = [
        'cv_denomination_numeric', 'cv_year_start', 'cv_year_end',
        'cv_weight_grams', 'cv_diameter_mm', 'cv_grade_numeric',
        'cv_population_obverse', 'cv_population_reverse', 'cv_quantity',
        'cv_duplicate_count',
    ];
    foreach ( $number_fields as $key ) {
        register_post_meta( 'coin_vault_item', $key, [
            'type'         => 'number',
            'single'       => true,
            'show_in_rest' => true,
        ] );
    }

    $bool_fields = [
        'cv_is_public', 'cv_is_slabbed', 'cv_details_grade', 'cv_is_star_note',
    ];
    foreach ( $bool_fields as $key ) {
        register_post_meta( 'coin_vault_item', $key, [
            'type'         => 'boolean',
            'single'       => true,
            'show_in_rest' => true,
        ] );
    }
} );

// ── REST API ──────────────────────────────────────────────────────────

add_action( 'rest_api_init', function () {
    $ns = 'coin-vault/v1';

    // Sync a single coin (create or update by cv_item_id)
    register_rest_route( $ns, '/sync', [
        'methods'             => 'POST',
        'callback'            => 'cv_sync_coin',
        'permission_callback' => 'cv_auth_check',
        'args'                => cv_sync_args(),
    ] );

    // Delete a coin by its app UUID
    register_rest_route( $ns, '/delete/(?P<item_id>[a-zA-Z0-9\-]+)', [
        'methods'             => 'DELETE',
        'callback'            => 'cv_delete_coin',
        'permission_callback' => 'cv_auth_check',
    ] );

    // List synced coins (for the app to verify state)
    register_rest_route( $ns, '/list', [
        'methods'             => 'GET',
        'callback'            => 'cv_list_coins',
        'permission_callback' => 'cv_auth_check',
    ] );

    // Health check — confirm plugin is active
    register_rest_route( $ns, '/ping', [
        'methods'             => 'GET',
        'callback'            => function () {
            return new WP_REST_Response( [ 'status' => 'ok', 'version' => '1.0.0' ], 200 );
        },
        'permission_callback' => '__return_true',
    ] );
} );

// ── Auth ──────────────────────────────────────────────────────────────

function cv_auth_check() {
    // Requires WordPress Application Password (built-in since WP 5.6)
    return current_user_can( 'edit_posts' );
}

// ── Sync handler ──────────────────────────────────────────────────────

function cv_sync_coin( WP_REST_Request $req ) {
    $params   = $req->get_json_params();
    $item_id  = sanitize_text_field( $params['id'] ?? '' );

    if ( empty( $item_id ) ) {
        return new WP_Error( 'missing_id', 'Item id is required.', [ 'status' => 400 ] );
    }

    // Look for existing post with this app UUID
    $existing = get_posts( [
        'post_type'      => 'coin_vault_item',
        'post_status'    => 'any',
        'meta_key'       => 'cv_item_id',
        'meta_value'     => $item_id,
        'posts_per_page' => 1,
        'fields'         => 'ids',
    ] );

    $post_title   = cv_build_title( $params );
    $post_content = cv_build_content( $params );
    $post_status  = ! empty( $params['is_public'] ) ? 'publish' : 'private';

    if ( ! empty( $existing ) ) {
        $post_id = wp_update_post( [
            'ID'           => $existing[0],
            'post_title'   => $post_title,
            'post_content' => $post_content,
            'post_status'  => $post_status,
        ], true );
    } else {
        $post_id = wp_insert_post( [
            'post_type'    => 'coin_vault_item',
            'post_title'   => $post_title,
            'post_content' => $post_content,
            'post_status'  => $post_status,
        ], true );
    }

    if ( is_wp_error( $post_id ) ) {
        return $post_id;
    }

    cv_save_meta( $post_id, $params, $item_id );

    return new WP_REST_Response( [
        'post_id'  => $post_id,
        'item_id'  => $item_id,
        'status'   => $post_status,
        'url'      => get_permalink( $post_id ),
    ], 200 );
}

// ── Delete handler ────────────────────────────────────────────────────

function cv_delete_coin( WP_REST_Request $req ) {
    $item_id = sanitize_text_field( $req->get_param( 'item_id' ) );

    $existing = get_posts( [
        'post_type'      => 'coin_vault_item',
        'post_status'    => 'any',
        'meta_key'       => 'cv_item_id',
        'meta_value'     => $item_id,
        'posts_per_page' => 1,
        'fields'         => 'ids',
    ] );

    if ( empty( $existing ) ) {
        return new WP_Error( 'not_found', 'Coin not found.', [ 'status' => 404 ] );
    }

    wp_delete_post( $existing[0], true );

    return new WP_REST_Response( [ 'deleted' => true, 'item_id' => $item_id ], 200 );
}

// ── List handler ──────────────────────────────────────────────────────

function cv_list_coins( WP_REST_Request $req ) {
    $posts = get_posts( [
        'post_type'      => 'coin_vault_item',
        'post_status'    => [ 'publish', 'private' ],
        'posts_per_page' => -1,
        'fields'         => 'ids',
    ] );

    $result = array_map( function ( $id ) {
        return [
            'post_id' => $id,
            'item_id' => get_post_meta( $id, 'cv_item_id', true ),
            'url'     => get_permalink( $id ),
            'status'  => get_post_status( $id ),
        ];
    }, $posts );

    return new WP_REST_Response( $result, 200 );
}

// ── Helpers ───────────────────────────────────────────────────────────

function cv_build_title( array $p ): string {
    $parts = array_filter( [
        $p['year_start'] ?? null,
        $p['series']     ?? null,
        $p['denomination'] ?? null,
        $p['country']    ?? null,
    ] );
    return implode( ' ', $parts ) ?: 'Untitled Coin';
}

function cv_build_content( array $p ): string {
    $lines = [];

    if ( ! empty( $p['historical_context'] ) )
        $lines[] = '<p>' . esc_html( $p['historical_context'] ) . '</p>';

    if ( ! empty( $p['obverse_description'] ) )
        $lines[] = '<p><strong>Obverse:</strong> ' . esc_html( $p['obverse_description'] ) . '</p>';

    if ( ! empty( $p['reverse_description'] ) )
        $lines[] = '<p><strong>Reverse:</strong> ' . esc_html( $p['reverse_description'] ) . '</p>';

    if ( ! empty( $p['attribution_notes'] ) )
        $lines[] = '<p><strong>Attribution:</strong> ' . esc_html( $p['attribution_notes'] ) . '</p>';

    return implode( "\n", $lines );
}

function cv_save_meta( int $post_id, array $p, string $item_id ): void {
    $map = [
        'cv_item_id'             => $item_id,
        'cv_item_type'           => $p['item_type']            ?? 'coin',
        'cv_country'             => $p['country']              ?? '',
        'cv_issuing_authority'   => $p['issuing_authority']    ?? '',
        'cv_denomination'        => $p['denomination']         ?? '',
        'cv_denomination_numeric'=> $p['denomination_numeric'] ?? '',
        'cv_year_start'          => $p['year_start']           ?? '',
        'cv_year_end'            => $p['year_end']             ?? '',
        'cv_mint_mark'           => $p['mint_mark']            ?? '',
        'cv_series'              => $p['series']               ?? '',
        'cv_variety'             => $p['variety']              ?? '',
        'cv_is_public'           => ! empty( $p['is_public'] ),
        'cv_metal'               => $p['metal']                ?? '',
        'cv_weight_grams'        => $p['weight_grams']         ?? '',
        'cv_diameter_mm'         => $p['diameter_mm']          ?? '',
        'cv_edge_type'           => $p['edge_type']            ?? '',
        'cv_coin_orientation'    => $p['coin_orientation']     ?? '',
        'cv_obverse_description' => $p['obverse_description']  ?? '',
        'cv_reverse_description' => $p['reverse_description']  ?? '',
        'cv_edge_description'    => $p['edge_description']     ?? '',
        'cv_die_markers'         => $p['die_markers']          ?? '',
        'cv_grade'               => $p['grade']                ?? '',
        'cv_grade_numeric'       => $p['grade_numeric']        ?? '',
        'cv_grading_company'     => $p['grading_company']      ?? '',
        'cv_cert_number'         => $p['cert_number']          ?? '',
        'cv_is_slabbed'          => ! empty( $p['is_slabbed'] ),
        'cv_details_grade'       => ! empty( $p['details_grade'] ),
        'cv_designation'         => $p['designation']          ?? '',
        'cv_population_obverse'  => $p['population_obverse']   ?? '',
        'cv_population_reverse'  => $p['population_reverse']   ?? '',
        'cv_submission_status'   => $p['submission_status']    ?? 'raw',
        'cv_quantity'            => $p['quantity']             ?? 1,
        'cv_duplicate_count'     => $p['duplicate_count']      ?? 0,
        'cv_historical_context'  => $p['historical_context']   ?? '',
        'cv_attribution_notes'   => $p['attribution_notes']    ?? '',
        'cv_provenance'          => $p['provenance']           ?? '',
        'cv_internal_notes'      => $p['internal_notes']       ?? '',
    ];

    foreach ( $map as $key => $value ) {
        update_post_meta( $post_id, $key, $value );
    }
}

function cv_sync_args(): array {
    return [
        'id' => [ 'required' => true, 'type' => 'string' ],
    ];
}
