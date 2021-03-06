package cfg;

/**
 * 配置文件常量
 * @author Wymann
 * 2013-10-6 上午10:01:27
 */
public class PropertyConst {
	
	//--------------------------------------------sql常量-----------------------------------
	public static final String SQL_TYPE="sql.type";
	
	//--------------------------------------------邮件服务常量-----------------------------------
	public static final String MAIL_SERVERHOST="mail.ServerHost";
	public static final String MAIL_SERVERPORT="mail.ServerPort";
	public static final String MAIL_AUTHVALIDATE="mail.authValidate";
	public static final String MAIL_USERNAME="mail.userName";
	public static final String MAIL_USERPASSWORD="mail.userPassword";
	public static final String MAIL_FROMADDRESS="mail.fromAddress";
	public static final String MAIL_FROMUSERNAME="mail.fromUserName";
	
	//-------------------------------------------文件上传路径-------------------------
	public static final String UPLOAD_FILE="upload.root";			//上传文件根目录
	public static final String CONTRACT_FILE="upload.contract";				//上传合同目录
	public static final String TEMP_FILE="upload.temp";						//临时文件目录
	
	
	//-------------------------------------------公司名称-------------------------
	public static final String COMPANY_NAME="company.name";			//本公司名称
	public static final String CUSTOMER_NAME="customer.name";		//总公司名称
	
	//-------------------------------------------默认客户类型-------------------------
	public static final String CUSTOMER_WBDW="customer.wbdw";			//外部单位

	public static final String ASSETNAM_WBDW = "assetnam.wbdw";
	
}
