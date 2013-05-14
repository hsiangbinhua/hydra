--创建seed表
CREATE TABLE 'TB_DATA_SEED' (
  'ID' int(11) NOT NULL AUTO_INCREMENT,
  'VALUE' bigint(11) DEFAULT NULL,
  PRIMARY KEY ('ID')
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8

--创建app表
CREATE TABLE 'TB_PARA_APP' (
  'ID' int(11) NOT NULL AUTO_INCREMENT,
  'NAME' varchar(100) DEFAULT NULL,
  PRIMARY KEY ('ID')
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8

--创建service表
CREATE TABLE 'TB_PARA_SERVICE' (
  'ID' varchar(6) NOT NULL,
  'NAME' varchar(100) DEFAULT NULL,
  'APP_ID' int(11) DEFAULT NULL,
  PRIMARY KEY ('ID'),
  KEY 'fk_appId' ('APP_ID'),
  CONSTRAINT 'fk_appId' FOREIGN KEY ('APP_ID') REFERENCES 'TB_PARA_APP' ('ID') ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='utf8_general_ci'

--创建serviceId生成策略表
CREATE TABLE 'TB_PARA_SERVICE_ID_GEN' (
  'MAX_ID' int(11) NOT NULL,
  'HEAD' int(11) NOT NULL,
  'MAX_HEAD' int(11) NOT NULL,
  'ID_SCOPE' int(11) NOT NULL,
  PRIMARY KEY ('MAX_ID')
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='utf8_general_ci'

--初始化生成策略数据，serviceId由head+max_id两部分组成max_id和head分别自增。
--head自增至26之后重置为0（为了配合hbase分区策略，hbase分多少个区，则max_head为多少）
--max_id自增值9999后后重置为0
INSERT INTO 'TB_PARA_SERVICE_ID_GEN' VALUES (0, 0, 26, 10000)