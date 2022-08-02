# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_02_032406) do

  create_table "column_stats", primary_key: ["db_name", "table_name", "column_name"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Statistics on Columns", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "db_name", limit: 64, null: false
    t.string "table_name", limit: 64, null: false
    t.string "column_name", limit: 64, null: false
    t.binary "min_value", limit: 255
    t.binary "max_value", limit: 255
    t.decimal "nulls_ratio", precision: 12, scale: 4
    t.decimal "avg_length", precision: 12, scale: 4
    t.decimal "avg_frequency", precision: 12, scale: 4
    t.integer "hist_size", limit: 1, unsigned: true
    t.column "hist_type", "enum('SINGLE_PREC_HB','DOUBLE_PREC_HB','JSON_HB')"
    t.binary "histogram", size: :long
  end

  create_table "columns_priv", primary_key: ["Host", "Db", "User", "Table_name", "Column_name"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Column privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "Db", limit: 64, default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.string "Table_name", limit: 64, default: "", null: false
    t.string "Column_name", limit: 64, default: "", null: false
    t.timestamp "Timestamp", default: -> { "current_timestamp()" }, null: false
    t.column "Column_priv", "set('Select','Insert','Update','References')", default: "", null: false, collation: "utf8mb3_general_ci"
  end

  create_table "db", primary_key: ["Host", "Db", "User"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Database privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "Db", limit: 64, default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.column "Select_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Insert_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Update_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Delete_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Create_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Drop_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Grant_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "References_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Index_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Alter_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Create_tmp_table_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Lock_tables_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Create_view_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Show_view_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Create_routine_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Alter_routine_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Execute_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Event_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Trigger_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.column "Delete_history_priv", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.index ["User"], name: "User"
  end

  create_table "event", primary_key: ["db", "name"], charset: "utf8mb3", comment: "Events", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "db", limit: 64, default: "", null: false, collation: "utf8mb3_bin"
    t.string "name", limit: 64, default: "", null: false
    t.binary "body", size: :long, null: false
    t.string "definer", limit: 384, default: "", null: false, collation: "utf8mb3_bin"
    t.datetime "execute_at"
    t.integer "interval_value"
    t.column "interval_field", "enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND')"
    t.timestamp "created", default: -> { "current_timestamp()" }, null: false
    t.timestamp "modified", null: false
    t.datetime "last_executed"
    t.datetime "starts"
    t.datetime "ends"
    t.column "status", "enum('ENABLED','DISABLED','SLAVESIDE_DISABLED')", default: "ENABLED", null: false
    t.column "on_completion", "enum('DROP','PRESERVE')", default: "DROP", null: false
    t.column "sql_mode", "set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL')", default: "", null: false
    t.string "comment", limit: 64, default: "", null: false, collation: "utf8mb3_bin"
    t.integer "originator", null: false, unsigned: true
    t.string "time_zone", limit: 64, default: "SYSTEM", null: false, collation: "latin1_swedish_ci"
    t.string "character_set_client", limit: 32, collation: "utf8mb3_bin"
    t.string "collation_connection", limit: 32, collation: "utf8mb3_bin"
    t.string "db_collation", limit: 32, collation: "utf8mb3_bin"
    t.binary "body_utf8", size: :long
  end

  create_table "func", primary_key: "name", id: { type: :string, limit: 64, default: "" }, charset: "utf8mb3", collation: "utf8mb3_bin", comment: "User defined functions", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.boolean "ret", default: false, null: false
    t.string "dl", limit: 128, default: "", null: false
    t.column "type", "enum('function','aggregate')", null: false, collation: "utf8mb3_general_ci"
  end

  create_table "general_log", id: false, charset: "utf8mb3", comment: "General log", options: "ENGINE=CSV", force: :cascade do |t|
    t.timestamp "event_time", precision: 6, default: -> { "current_timestamp(6)" }, null: false
    t.text "user_host", size: :medium, null: false
    t.bigint "thread_id", null: false, unsigned: true
    t.integer "server_id", null: false, unsigned: true
    t.string "command_type", limit: 64, null: false
    t.text "argument", size: :medium, null: false
  end

  create_table "global_priv", primary_key: ["Host", "User"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Users and global privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.text "Priv", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.check_constraint "json_valid(`Priv`)", name: "Priv"
  end

  create_table "gtid_slave_pos", primary_key: ["domain_id", "sub_id"], charset: "latin1", comment: "Replication slave GTID position", force: :cascade do |t|
    t.integer "domain_id", null: false, unsigned: true
    t.bigint "sub_id", null: false, unsigned: true
    t.integer "server_id", null: false, unsigned: true
    t.bigint "seq_no", null: false, unsigned: true
  end

  create_table "help_category", primary_key: "help_category_id", id: { type: :integer, limit: 2, unsigned: true, default: nil }, charset: "utf8mb3", comment: "help categories", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.integer "parent_category_id", limit: 2, unsigned: true
    t.text "url", null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "help_keyword", primary_key: "help_keyword_id", id: { type: :integer, unsigned: true, default: nil }, charset: "utf8mb3", comment: "help keywords", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "help_relation", primary_key: ["help_keyword_id", "help_topic_id"], charset: "utf8mb3", comment: "keyword-topic relation", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.integer "help_topic_id", null: false, unsigned: true
    t.integer "help_keyword_id", null: false, unsigned: true
    t.index ["help_topic_id"], name: "help_topic_id"
  end

  create_table "help_topic", primary_key: "help_topic_id", id: { type: :integer, unsigned: true, default: nil }, charset: "utf8mb3", comment: "help topics", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.integer "help_category_id", limit: 2, null: false, unsigned: true
    t.text "description", null: false
    t.text "example", null: false
    t.text "url", null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "index_stats", primary_key: ["db_name", "table_name", "index_name", "prefix_arity"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Statistics on Indexes", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "db_name", limit: 64, null: false
    t.string "table_name", limit: 64, null: false
    t.string "index_name", limit: 64, null: false
    t.integer "prefix_arity", null: false, unsigned: true
    t.decimal "avg_frequency", precision: 12, scale: 4
  end

  create_table "innodb_index_stats", primary_key: ["database_name", "table_name", "index_name", "stat_name"], charset: "utf8mb3", collation: "utf8mb3_bin", options: "ENGINE=InnoDB STATS_PERSISTENT=0", force: :cascade do |t|
    t.string "database_name", limit: 64, null: false
    t.string "table_name", limit: 199, null: false
    t.string "index_name", limit: 64, null: false
    t.timestamp "last_update", default: -> { "current_timestamp()" }, null: false
    t.string "stat_name", limit: 64, null: false
    t.bigint "stat_value", null: false, unsigned: true
    t.bigint "sample_size", unsigned: true
    t.string "stat_description", limit: 1024, null: false
  end

  create_table "innodb_table_stats", primary_key: ["database_name", "table_name"], charset: "utf8mb3", collation: "utf8mb3_bin", options: "ENGINE=InnoDB STATS_PERSISTENT=0", force: :cascade do |t|
    t.string "database_name", limit: 64, null: false
    t.string "table_name", limit: 199, null: false
    t.timestamp "last_update", default: -> { "current_timestamp()" }, null: false
    t.bigint "n_rows", null: false, unsigned: true
    t.bigint "clustered_index_size", null: false, unsigned: true
    t.bigint "sum_of_other_index_sizes", null: false, unsigned: true
  end

  create_table "plugin", primary_key: "name", id: { type: :string, limit: 64, default: "" }, charset: "utf8mb3", comment: "MySQL plugins", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "dl", limit: 128, default: "", null: false
  end

  create_table "proc", primary_key: ["db", "name", "type"], charset: "utf8mb3", comment: "Stored Procedures", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "db", limit: 64, default: "", null: false, collation: "utf8mb3_bin"
    t.string "name", limit: 64, default: "", null: false
    t.column "type", "enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY')", null: false
    t.string "specific_name", limit: 64, default: "", null: false
    t.column "language", "enum('SQL')", default: "SQL", null: false
    t.column "sql_data_access", "enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA')", default: "CONTAINS_SQL", null: false
    t.column "is_deterministic", "enum('YES','NO')", default: "NO", null: false
    t.column "security_type", "enum('INVOKER','DEFINER')", default: "DEFINER", null: false
    t.binary "param_list", null: false
    t.binary "returns", size: :long, null: false
    t.binary "body", size: :long, null: false
    t.string "definer", limit: 384, default: "", null: false, collation: "utf8mb3_bin"
    t.timestamp "created", default: -> { "current_timestamp()" }, null: false
    t.timestamp "modified", null: false
    t.column "sql_mode", "set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL')", default: "", null: false
    t.text "comment", null: false, collation: "utf8mb3_bin"
    t.string "character_set_client", limit: 32, collation: "utf8mb3_bin"
    t.string "collation_connection", limit: 32, collation: "utf8mb3_bin"
    t.string "db_collation", limit: 32, collation: "utf8mb3_bin"
    t.binary "body_utf8", size: :long
    t.column "aggregate", "enum('NONE','GROUP')", default: "NONE", null: false
  end

  create_table "procs_priv", primary_key: ["Host", "Db", "User", "Routine_name", "Routine_type"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Procedure privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "Db", limit: 64, default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.string "Routine_name", limit: 64, default: "", null: false, collation: "utf8mb3_general_ci"
    t.column "Routine_type", "enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY')", null: false
    t.string "Grantor", limit: 384, default: "", null: false
    t.column "Proc_priv", "set('Execute','Alter Routine','Grant')", default: "", null: false, collation: "utf8mb3_general_ci"
    t.timestamp "Timestamp", default: -> { "current_timestamp()" }, null: false
    t.index ["Grantor"], name: "Grantor"
  end

  create_table "proxies_priv", primary_key: ["Host", "User", "Proxied_host", "Proxied_user"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "User proxy privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.string "Proxied_host", default: "", null: false
    t.string "Proxied_user", limit: 128, default: "", null: false
    t.boolean "With_grant", default: false, null: false
    t.string "Grantor", limit: 384, default: "", null: false
    t.timestamp "Timestamp", default: -> { "current_timestamp()" }, null: false
    t.index ["Grantor"], name: "Grantor"
  end

  create_table "roles_mapping", id: false, charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Granted roles", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.string "Role", limit: 128, default: "", null: false
    t.column "Admin_option", "enum('N','Y')", default: "N", null: false, collation: "utf8mb3_general_ci"
    t.index ["Host", "User", "Role"], name: "Host", unique: true
  end

  create_table "servers", primary_key: "Server_name", id: { type: :string, limit: 64, default: "" }, charset: "utf8mb3", comment: "MySQL Foreign Servers table", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", limit: 2048, default: "", null: false
    t.string "Db", limit: 64, default: "", null: false
    t.string "Username", limit: 128, default: "", null: false
    t.string "Password", limit: 64, default: "", null: false
    t.integer "Port", default: 0, null: false
    t.string "Socket", limit: 64, default: "", null: false
    t.string "Wrapper", limit: 64, default: "", null: false
    t.string "Owner", limit: 512, default: "", null: false
  end

  create_table "slow_log", id: false, charset: "utf8mb3", comment: "Slow log", options: "ENGINE=CSV", force: :cascade do |t|
    t.timestamp "start_time", precision: 6, default: -> { "current_timestamp(6)" }, null: false
    t.text "user_host", size: :medium, null: false
    t.time "query_time", precision: 6, null: false
    t.time "lock_time", precision: 6, null: false
    t.integer "rows_sent", null: false
    t.integer "rows_examined", null: false
    t.string "db", limit: 512, null: false
    t.integer "last_insert_id", null: false
    t.integer "insert_id", null: false
    t.integer "server_id", null: false, unsigned: true
    t.text "sql_text", size: :medium, null: false
    t.bigint "thread_id", null: false, unsigned: true
    t.integer "rows_affected", null: false
  end

  create_table "table_stats", primary_key: ["db_name", "table_name"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Statistics on Tables", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=0", force: :cascade do |t|
    t.string "db_name", limit: 64, null: false
    t.string "table_name", limit: 64, null: false
    t.bigint "cardinality", unsigned: true
  end

  create_table "tables_priv", primary_key: ["Host", "Db", "User", "Table_name"], charset: "utf8mb3", collation: "utf8mb3_bin", comment: "Table privileges", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.string "Host", default: "", null: false
    t.string "Db", limit: 64, default: "", null: false
    t.string "User", limit: 128, default: "", null: false
    t.string "Table_name", limit: 64, default: "", null: false
    t.string "Grantor", limit: 384, default: "", null: false
    t.timestamp "Timestamp", default: -> { "current_timestamp()" }, null: false
    t.column "Table_priv", "set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger','Delete versioning rows')", default: "", null: false, collation: "utf8mb3_general_ci"
    t.column "Column_priv", "set('Select','Insert','Update','References')", default: "", null: false, collation: "utf8mb3_general_ci"
    t.index ["Grantor"], name: "Grantor"
  end

  create_table "time_zone", primary_key: "Time_zone_id", id: { type: :integer, unsigned: true }, charset: "utf8mb3", comment: "Time zones", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.column "Use_leap_seconds", "enum('Y','N')", default: "N", null: false
  end

  create_table "time_zone_leap_second", primary_key: "Transition_time", id: :bigint, default: nil, charset: "utf8mb3", comment: "Leap seconds information for time zones", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.integer "Correction", null: false
  end

  create_table "time_zone_name", primary_key: "Name", id: { type: :string, limit: 64 }, charset: "utf8mb3", comment: "Time zone names", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.integer "Time_zone_id", null: false, unsigned: true
  end

  create_table "time_zone_transition", primary_key: ["Time_zone_id", "Transition_time"], charset: "utf8mb3", comment: "Time zone transitions", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.integer "Time_zone_id", null: false, unsigned: true
    t.bigint "Transition_time", null: false
    t.integer "Transition_type_id", null: false, unsigned: true
  end

  create_table "time_zone_transition_type", primary_key: ["Time_zone_id", "Transition_type_id"], charset: "utf8mb3", comment: "Time zone transition types", options: "ENGINE=Aria PAGE_CHECKSUM=1 TRANSACTIONAL=1", force: :cascade do |t|
    t.integer "Time_zone_id", null: false, unsigned: true
    t.integer "Transition_type_id", null: false, unsigned: true
    t.integer "Offset", default: 0, null: false
    t.integer "Is_DST", limit: 1, default: 0, null: false, unsigned: true
    t.string "Abbreviation", limit: 8, default: "", null: false
  end

  create_table "transaction_registry", primary_key: "transaction_id", id: { type: :bigint, unsigned: true, default: nil }, charset: "utf8mb3", collation: "utf8mb3_bin", options: "ENGINE=InnoDB STATS_PERSISTENT=0", force: :cascade do |t|
    t.bigint "commit_id", null: false, unsigned: true
    t.timestamp "begin_timestamp", precision: 6, null: false
    t.timestamp "commit_timestamp", precision: 6, null: false
    t.column "isolation_level", "enum('READ-UNCOMMITTED','READ-COMMITTED','REPEATABLE-READ','SERIALIZABLE')", null: false
    t.index ["begin_timestamp"], name: "begin_timestamp"
    t.index ["commit_id"], name: "commit_id", unique: true
    t.index ["commit_timestamp", "transaction_id"], name: "commit_timestamp"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
