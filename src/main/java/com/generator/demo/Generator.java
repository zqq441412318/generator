package com.generator.demo;

import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zqq
 * @date 2021/2/24 14:49
 */
public class Generator {

    //工程路径
    private static final String projectPath = "D:\\workspace\\mybatisplus"; //System.getProperty("user.dir")

    //数据库连接信息
    private static final String jdbc_url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
    private static final String driver_name = "com.mysql.cj.jdbc.Driver";
    private static final String user_name = "root";
    private static final String password = "root";
    //表名
    private static final String[] tableNames = {"member"};
    //作者
    private static final String author = "zqq";

    //包路径
    private static final String entity_package = "com.example.demo.core";
    private static final String dao_package = "com.example.demo.mapper";
    private static final String service_package = "com.example.demo.service";
    private static final String service_impl_package = "com.example.demo.service.impl";
    private static final String mapper_xml_pah = projectPath + "/src/main/resources/mapper/"; //自定义xml文件路径

    //是否使用LomBok生成类信息
    private static final Boolean useLomBok = true;

    public static void main(String[] args) {
        new Generator().execute();
    }

    public void execute(){
        //代码生成器
        AutoGenerator generator = new AutoGenerator();
        //全局配置
        GlobalConfig globalConfig = new GlobalConfig();
        globalConfig.setOutputDir(projectPath + "/src/main/java"); //生成文件的输出目录
        globalConfig.setFileOverride(true);//是否覆盖已有文件，默认false
        globalConfig.setAuthor(author);//开发人员，默认null
        globalConfig.setOpen(false);//是否打开输出目录，默认true

        globalConfig.setEntityName("%s");//实体命名方式,%s占位符
        globalConfig.setMapperName("%sMapper");
        globalConfig.setXmlName("%sMapper");
        globalConfig.setServiceName("%sService");
        globalConfig.setServiceImplName("%sServiceImpl");
        generator.setGlobalConfig(globalConfig);

        //数据源配置
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setUrl(jdbc_url);
        dataSourceConfig.setDriverName(driver_name);
        dataSourceConfig.setUsername(user_name);
        dataSourceConfig.setPassword(password);
        generator.setDataSource(dataSourceConfig);

        //包配置
        PackageConfig packageConfig = new PackageConfig();
        packageConfig.setParent(null); //父包名，如果为空，将下面子包名必须写全部， 否则就只需写子包名
        packageConfig.setEntity(entity_package);//实体报名
        packageConfig.setMapper(dao_package);//mapper包名
        packageConfig.setService(service_package);//service接口包名
        packageConfig.setServiceImpl(service_impl_package);//service实现类包名
        generator.setPackageInfo(packageConfig);

        //自定义配置，生成默认方法，在 resources下Freemarker模板判断生成
        InjectionConfig injectionConfig = new InjectionConfig() {
            @Override
            public void initMap() {
                //在.ftl模板中，通过${cfg.findById}获取属性
                Map<String,Object> map = new HashMap<String,Object>(6);
                map.put("findById",true);
                map.put("deleteById",true);
                map.put("updateById",true);
                map.put("insert",true);
                map.put("insertBatch",true);
                map.put("updateBatch",true);
                this.setMap(map);
            }
        };

        //freemarker模板引擎
        String mapperXml = "/templates/mapper.xml.ftl";
        //自定义配置会被优先输出
        List<FileOutConfig> fileOutConfigs = new ArrayList<FileOutConfig>();
        fileOutConfigs.add(new FileOutConfig(mapperXml) {
            @Override
            public String outputFile(TableInfo tableInfo) {
                return mapper_xml_pah + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
            }
        });
        injectionConfig.setFileOutConfigList(fileOutConfigs);
        generator.setCfg(injectionConfig);

        //模板配置
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setXml(null); //设置成null则不生成
        templateConfig.setController(null);
        //templateConfig.setEntity(null);
        //templateConfig.setService(null);
        //templateConfig.setServiceImpl(null);
        //templateConfig.setMapper(null);
        generator.setTemplate(templateConfig);

        //策略配置
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig.setNaming(NamingStrategy.underline_to_camel);// 数据库表映射到实体的命名策略
        strategyConfig.setColumnNaming(NamingStrategy.underline_to_camel);//数据库表字段映射到实体的命名策略, 未指定按照 naming 执行
        //strategyConfig.setSuperEntityClass(null); // 自定义继承的Entity类全称，带包名
        strategyConfig.setInclude(tableNames);//表明，多个用逗号隔开
        strategyConfig.setControllerMappingHyphenStyle(true); //驼峰转连字符
        strategyConfig.setEntityLombokModel(useLomBok);//是否使用Lombok
        strategyConfig.setEntitySerialVersionUID(false);
        generator.setStrategy(strategyConfig);

        generator.setTemplateEngine(new FreemarkerTemplateEngine()); //设置模板
        generator.execute();//执行
    }
}
