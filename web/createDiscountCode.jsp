<%-- 
    Document   : createDiscountCode
    Created on : 13 thg 6, 2021, 17:56:34
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Discount Code</title>
    </head>
    <body>
        <script>
            function createRandomCode()
            {
                const DISCOUNT_CODE_LENGTH = 20; // Do dai code giam gia
                var btn = document.getElementById("randomCodeButton");
                var randomCode = makeid(DISCOUNT_CODE_LENGTH)
                document.getElementById("txtCode").value = randomCode;
            }

            function makeid(length) {
                var result = '';
                var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                var charactersLength = characters.length;
                for (var i = 0; i < length; i++) {
                    result += characters.charAt(Math.floor(Math.random() *
                            charactersLength));
                }
                return result;
            }

        </script>
        <div style="width: 50%; margin-left: 25%">
            <form action="createDiscountCode" method="POST">

                <table border="1" style="min-width: 80%">
                    <tbody style="min-width: 80%">
                        <tr>
                            <td>Code</td>
                            <td>
                                <input type="text" maxlength="20" required="true" id="txtCode" name="txtCode" placeholder="Nhap vao code giam gia" style="width: 73%" value="" oninput="this.value = this.value.toUpperCase()"/>
                                <form action="" method="POST">
                                    <input type="button" value="Random Code" id="randomCodeButton" onclick="createRandomCode()"/>
                                </form>
                            </td>
                        </tr>

                        <tr>
                            <td>Discount (%)</td>
                            <td>
                                <input type="number" value="" required="true" name="txtPercentDiscount" min="1" max="100" placeholder="Nhap vao phan tram giam gia" style="width: 73%"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Describe</td>
                            <td>
                                <input type="text" name="txtDescription" maxlength="300" placeholder="Nhap vao mo ta" value="" style="width: 73%"/>
                            </td>
                        </tr>

                    </tbody>

                </table>
                <c:if test="${not empty MSG_SUCCESS}">
                    <font color="green">
                    ${MSG_SUCCESS}
                    </font>
                </c:if>
                <br/>
                <input type="submit" value="Create" />
                <input type="reset" value="Reset" />
            </form>
            <br/>
            <br/><a href="search">Back</a>

        </div>
    </body>
</html>
