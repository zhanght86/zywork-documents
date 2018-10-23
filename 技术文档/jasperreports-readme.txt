项目中如果使用JasperReports导出PDF或HTML，PDF中文解决方案：
第一种解决方案：
1、下载jasperreports-fonts.jar包
2、解压后把系统带有的中文字体文件放入到解压后的net\sf\jasperreports\fonts\dejavu目录中，如simhei.ttf黑体字体
3、在fonts.xml文件中增加如下描述
    <fontFamily name="黑体">
            <normal>net/sf/jasperreports/fonts/dejavu/simhei.ttf</normal>
            <bold>net/sf/jasperreports/fonts/dejavu/simhei.ttf</bold>
            <italic>net/sf/jasperreports/fonts/dejavu/simhei.ttf</italic>
            <boldItalic>net/sf/jasperreports/fonts/dejavu/simhei.ttf</boldItalic>
            <pdfEncoding>Identity-H</pdfEncoding>
            <pdfEmbedded>true</pdfEmbedded>
            <exportFonts>
                <export key="net.sf.jasperreports.html">'黑体', Arial, Helvetica, sans-serif</export>
                <export key="net.sf.jasperreports.xhtml">'黑体', Arial, Helvetica, sans-serif</export>
            </exportFonts>
        </fontFamily>
4、重新打包为jasperreports-fonts.jar包
5、此包以Classes的形式加入到项目中
6、在JasperReports Studio中使用中文时，选择字体为simhei字体

第二种解决方案（推荐方案）：
1、下载jasperreports-fonts.jar包
2、在项目的resources目录下新建fonts目录
3、把需要的中文字体放入到第二步创建的fonts目录中，如simhei.ttf黑体字体
4、解压jar包，获取jasperreports_extension.properties文件，并拷贝到项目的resources目录中
5、修改第四步中的jasperreports_extension.properties文件为如下内容
    net.sf.jasperreports.awt.ignore.missing.font=true
    net.sf.jasperreports.extension.registry.factory.simple.font.families=net.sf.jasperreports.engine.fonts.SimpleFontExtensionsRegistryFactory
    net.sf.jasperreports.extension.simple.font.families.dejavu=fonts/fonts.xml
6、在解压的jar目录中获取fonts.xml文件，拷贝到第二步创建的fonts目录中
7、修改fonts目录中的fonts.xml文件，末尾片添加如下内容
    <fontFamily name="黑体">
            <normal>fonts/simhei.ttf</normal>
            <bold>fonts/simhei.ttf</bold>
            <italic>fonts/simhei.ttf</italic>
            <boldItalic>fonts/simhei.ttf</boldItalic>
            <pdfEncoding>Identity-H</pdfEncoding>
            <pdfEmbedded>true</pdfEmbedded>
            <exportFonts>
                <export key="net.sf.jasperreports.html">'黑体', Arial, Helvetica, sans-serif</export>
                <export key="net.sf.jasperreports.xhtml">'黑体', Arial, Helvetica, sans-serif</export>
            </exportFonts>
        </fontFamily>
8、项目中使用maven引用jasperreports-fonts
9、在JasperReports Studio中使用中文时，选择字体为simhei字体